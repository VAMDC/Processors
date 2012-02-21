# -*- coding: utf-8 -*-

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseNotFound
from django.forms import Form,FileField,URLField,TextInput
from django.core.exceptions import ValidationError

from lxml import etree as e
from urllib2 import urlopen
import os
import threading

from models import Conversion

from django.conf import settings
STATIC=settings.STATIC_DIR
XSL_MIME = {'xsams2sme':'text/csv',
            }

class ConversionForm(Form):
    upload = FileField(label='Input file',required=False)
    url = URLField(label='Input URL',required=False,widget=TextInput(attrs={'size': 50, 'title': 'Paste here a URL that delivers an XSAMS document.',}))

    def clean(self):
        upload = self.cleaned_data.get('upload')
        url = self.cleaned_data.get('url')
        if (upload and url):
            raise ValidationError('Give either input file or URL!')

        if url:
            try: data = urlopen(url)
            except Exception,err:
                raise ValidationError('Could not open given URL: %s'%err)
        elif upload: data = upload
        else:
            raise ValidationError('Give either input file or URL!')

        return self.cleaned_data

def showForm(request,xsl):
    if xsl not in XSL_MIME:
        return HttpResponseNotFound()
    ConvForm = ConversionForm()
    return render_to_response('applyXSL.html',
            RequestContext(request,dict(conversion=ConvForm)))

def receiveInput(request,xsl):
    ConvForm = ConversionForm(request.REQUEST, request.FILES)
    if ConvForm.is_valid():
        print ConvForm.cleaned_data
        conv = Conversion(xsl=xsl,
                   upload=ConvForm.cleaned_data['upload'],
                   url=ConvForm.cleaned_data['url'] )
        conv.save(force_insert=True)
        response=HttpResponseRedirect('./result/%s'%conv.pk)
        return response
    else:
        return HttpResponseRedirect('.')

class DoWork(threading.Thread):
    def __init__(self, conv, outfile):
        threading.Thread.__init__(self)
        self.conv = conv
        self.outfile = open(outfile,'w')
        self.errfile = open(outfile+'.err','w')
    def run(self):
        xslfile = open(STATIC+'/xsl/%s.xsl'%self.conv.xsl)
        xsl = e.XSLT(e.parse(xslfile))

        try:
            if self.url:
                xml = e.parse(self.conv.url)
            elif self.upload:
                xml = e.parse(self.conv.upload)
            else:
                self.errfile.write('400 no data to transform\n')
                return
        except:
            self.errfile.write('400 input data seems to be broken XML\n')
            return

        try:
            self.outfile.write(str(xsl(xml)))
        except:
            self.errfile.write('500 transformation failed\n')

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
        # start the work in the background
        bg = DoWork(conv, outfile)
        bg.start()

        return render_to_response('wait5.html',RequestContext(request,{}))


