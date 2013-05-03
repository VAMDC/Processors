# -*- coding: utf-8 -*-

import os.path
from django.conf import settings
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import HttpResponse

URL = settings.DEPLOY_URL
STATIC = settings.STATIC_DIR

def index(request):
    c=RequestContext(request,{})
    return render_to_response('index.html', c)

def recordVotable(request):
    if request.method == 'POST':
        votable = request.POST.get('table', '')
        votable_id = request.POST.get('table_id')
        outfile = STATIC+'/votables'
        f = open(os.path.join(outfile,votable_id+'.xml'), 'w')
        f.write('<?xml version="1.0" encoding="UTF-8"?>'+votable)
        f.close()
    #return HttpResponse(settings.STATIC_URL+'votables/'+votable_id)
    return HttpResponse(URL+'votables/'+votable_id+'.xml')

