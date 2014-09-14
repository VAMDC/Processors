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


from django.conf import settings
STATIC=settings.STATIC_DIR
if hasattr(settings,'DEPLOY_URL'):
    APPURL = settings.DEPLOY_URL+'applyXSL/'
else:
    APPURL = '/applyXSL/'


if hasattr(settings,'SAXON_JAR'):
    import xsl
    useJAVAxsl = True
else: useJAVAxsl = False

from models import Conversion
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

def transformJAVA(conv,err=None):
    transformer = xsl.XslTransformerFactory.getXslTransformer(XSL_VERSION[self.conv.xsl])
    try:
        result = transformer.transform(self.conv)
    except:
        err = '500 transformation failed\n'
        result = None
    return err,result


def transformLXML(conv,err=None):
    xslfile = open(STATIC+'/xsl/%s.xsl'%conv.xsl)
    xsl = e.XSLT(e.parse(xslfile))
    try:
        if self.conv.url:
            xml = e.parse(urlopen(self.conv.url))
        elif self.conv.upload:
            xml = e.parse(self.conv.upload)
        else:
            err = '400 no data to transform\n'
    except:
        err = '400 input data seems to be broken XML\n'

    try:
        output = str(xsl(xml))
    except:
            err = '500 transformation failed\n'
            output=None
    return err,output

class DoWork(threading.Thread):
    def __init__(self, conv):
        threading.Thread.__init__(self)
        self.conv = conv
        self.outfile = STATIC+'/results/%s'%conv.pk

    def run(self):
        if useJAVAxsl:
            result,err = transformJAVA(self.conv)
        else:
            result,err = transformLXML(self.conv)

        if err:
            open(self.outfile+'.err','w').write(result)
        else:
            open(self.outfile,'w').write(result)


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
        return HttpResponseRedirect(APPURL+'%s/result/%s'%(xsl,conv.pk))
    else:
        return HttpResponseRedirect(APPURL+'%s/'%xsl)

def deliverResult(request,xsl,rid):
    conv = get_object_or_404(Conversion,pk=rid)
    outfile = STATIC+'/results/%s'%rid

    if os.path.exists(outfile+'.err'):
        errstring = open(outfile+'.err').readline()
        print errstring
        errcode, msg = errstring.split(' ',1)
        return HttpResponse(msg,status=errcode,content_type='text/plain')
    elif os.path.exists(outfile):
        return HttpResponse(open(outfile),content_type=XSL_MIME.get(xsl,'text/plain'))
    else:
        return HttpResponse(render(request,'wait5.html',{}),status=202)
