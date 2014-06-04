# -*- coding: utf-8 -*-

from django.shortcuts import render,render_to_response, get_object_or_404
from django.template import RequestContext
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseNotFound
from django.forms import Form,FileField,URLField,TextInput
from django.core.exceptions import ValidationError

from lxml import etree as e
from urllib2 import urlopen
import os
import threading
from time import sleep
import xsl

from models import Conversion

from django.conf import settings
STATIC=settings.STATIC_DIR
XSL_MIME = {'xsams2sme':'text/plain',
            'linespec':'image/svg+xml',
            'atomicxsams2html':'text/html',
            'molecularxsams2html':'text/html',
            'collisions2html':'text/html',}
            
XSL_VERSION = {'xsams2sme':1,
            'linespec':1,
            'atomicxsams2html':1,
            'molecularxsams2html':1,
            'collisions2html':2,}

class ConversionForm(Form):
    upload = FileField(label='Input file',required=False)
    url = URLField(label='Input URL',required=False,widget=TextInput(attrs={'size': 50, 'title': 'Paste here a URL that delivers an XSAMS document.',}))
    
    def clean(self):
        upload = self.cleaned_data.get('upload')

        url = self.cleaned_data.get('url')
        if (upload and url):
            raise ValidationError('Give either input file or URL!')

        return self.cleaned_data

def showForm(request,xsl):
    if xsl not in XSL_MIME:
        return HttpResponseNotFound()
    ConvForm = ConversionForm()
    return render_to_response('applyXSL.html',
            RequestContext(request,dict(conversion=ConvForm)))

class DoWork(threading.Thread):
    def __init__(self, conv):
        threading.Thread.__init__(self)
        self.conv = conv
        self.outfile = STATIC+'/results/%s'%conv.pk
        self.err = ''
        
    def run(self):
      transformer = xsl.XslTransformerFactory.getXslTransformer(XSL_VERSION[self.conv.xsl])
      result = transformer.transform(self.conv)
      
      try : 
        open(self.outfile,'w').write(result)
      except Exception, exc:
        open(self.outfile,'w').write(exc)
        

def receiveInput(request,xsl):
    ConvForm = ConversionForm(request.REQUEST, request.FILES)
    if ConvForm.is_valid():
        conv = Conversion(xsl=xsl,
                   upload=ConvForm.cleaned_data['upload'],
                   url=ConvForm.cleaned_data['url'] )
        conv.save(force_insert=True)

        # start the work in the background
        bg = DoWork(conv)
        bg.start()
        # give it a second, so we might skip the
        # waiting-page for quick transforms
        sleep(2)
        return HttpResponseRedirect(settings.DEPLOY_URL+'applyXSL/%s/result/%s'%(xsl,conv.pk))
    else:
        return HttpResponseRedirect(settings.DEPLOY_URL+'applyXSL/%s/'%xsl)

def deliverResult(request,xsl,rid):
    conv = get_object_or_404(Conversion,pk=rid)
    outfile = STATIC+'/results/%s'%rid

    if os.path.exists(outfile+'.err'):
        errcode, msg = open(outfile+'.err').readline().split(' ',1)
        return HttpResponse(msg,status=errcode,mimetype='text/plain')
    elif os.path.exists(outfile):
        return HttpResponse(open(outfile),mimetype=XSL_MIME.get(xsl,'text/plain'))
    else:
        return HttpResponse(render(request,'wait5.html',{}),status=202)


