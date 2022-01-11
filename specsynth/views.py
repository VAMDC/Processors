# -*- coding: utf-8 -*-

from django.shortcuts import render,get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.forms import Form,FileField,URLField,TextInput
from django.core.exceptions import ValidationError

from lxml import etree as e
from urllib.request import urlopen
import os
import threading
from time import sleep
import json
from .models import Spec

from django.conf import settings
STATIC = settings.STATIC_DIR
if hasattr(settings,'DEPLOY_URL'):
    APPURL = settings.DEPLOY_URL+'specsynth/'
else:
    APPURL = '/specsynth/'

def prepare_json(xml):
    root=xml.getroot()
    ns=root.nsmap[None]
    waves = root.xpath('//x:Wavelength[last()]/x:Value/text()',
        namespaces={'x':ns})
    loggfs = root.xpath('//x:Log10WeightedOscillatorStrength/x:Value/text()',
        namespaces={'x':ns})

    return [(float(wave),float(loggf)) for wave,loggf in zip(waves,loggfs)]
    #return [map(float,waves),map(float,loggfs)]

class ConversionForm(Form):
    upload = FileField(label='Input file',required=False)
    url = URLField(label='Input URL',required=False,
        widget=TextInput(attrs={'size': 50, 'title': 'Paste here a URL that delivers an XSAMS document.',}))

    def clean(self):
        cleaned_data = super(ConversionForm, self).clean()
        upload = cleaned_data.get('upload')
        url = cleaned_data.get('url')

        if (upload and url) or not (upload or url):
            raise ValidationError('Give either input file or URL!')

        return cleaned_data

def showForm(request):
    ConvForm = ConversionForm()
    return render(request, 'specsynth.html',
            dict(conversion=ConvForm))

class DoWork(threading.Thread):
    def __init__(self,conv):
        threading.Thread.__init__(self)
        self.outfile = STATIC+'/results/spec_%s.json'%conv.pk
        self.err = ''
        self.conv=conv
    def run(self):
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
            output = prepare_json(xml)
        except Exception as exc:
            print(exc)
            self.err += '500 transformation failed\n'

        if self.err:
            open(self.outfile+'.err','w').write(self.err)
        else:
            json.dump(output,open(self.outfile,'w'))

def receiveInput(request):
    ConvForm = ConversionForm(request.REQUEST, request.FILES)
    if ConvForm.is_valid():
        conv = Spec(upload=ConvForm.cleaned_data['upload'],
                   url=ConvForm.cleaned_data['url'] )
        conv.save(force_insert=True)

        # start the work in the background
        bg = DoWork(conv)
        bg.start()
        # give it a second, so we might skip the
        # waiting-page for quick transforms
        sleep(2)
        return HttpResponseRedirect(APPURL+'result/spec_%s.json'%(conv.pk))
    else:
        return HttpResponseRedirect(APPURL)

def deliverResult(request,rid):
    #log.debug('')
    conv = get_object_or_404(Spec,pk=rid)
    outfile = STATIC+'/results/spec_%s.json'%rid

    if os.path.exists(outfile+'.err'):
        errcode, msg = open(outfile+'.err').readline().split(' ',1)
        return HttpResponse(msg,status=errcode,content_type='text/plain')
    elif os.path.exists(outfile):
        return HttpResponse(open(outfile),content_type='application/json')

    else:
        return HttpResponse(render(request,'wait5.html',{}),status=202)
