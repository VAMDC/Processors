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

from models import Conversion

from django.conf import settings
STATIC=settings.STATIC_DIR
XSL_MIME = {'xsams2sme':'text/plain',
            'linespec':'image/svg+xml',
            'xsams2atomichtml':'text/html',}

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
        xslfile = open(STATIC+'/xsl/%s.xsl'%self.conv.xsl)
        xsl = e.XSLT(e.parse(xslfile))

        try:
            if self.conv.url:
                xml = e.parse(urlopen(self.conv.url))
            elif self.conv.upload:
                xml = e.parse(self.conv.upload)
            else:
                self.err += '400 no data to transform\n'
        except:
            self.err += '400 input data seems to be broken XML\n'

        try:
            output = str(xsl(xml))
        except:
            self.err += '500 transformation failed\n'

        if self.err:
            open(self.outfile+'.err','w').write(self.err)
        else:
            open(self.outfile,'w').write(output)

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
    #log.debug('')
    conv = get_object_or_404(Conversion,pk=rid)
    outfile = STATIC+'/results/%s'%rid

    if os.path.exists(outfile+'.err'):
        errcode, msg = open(outfile+'.err').readline().split(' ',1)
        return HttpResponse(msg,status=errcode,mimetype='text/plain')
    elif os.path.exists(outfile):
        return HttpResponse(open(outfile),mimetype=XSL_MIME.get(xsl,'text/plain'))
    else:
        return HttpResponse(render(request,'wait5.html',{}),status=202)


