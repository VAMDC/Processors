from django.conf.urls import patterns, include, url

urlpatterns = patterns('specsynth.views',
    (r'^$', 'showForm'),
    (r'service$', 'receiveInput'),
    (r'result/spec_(?P<rid>\w+).json$', 'deliverResult'),
    #(r'^(?P<xsl>\w+)/availability$', direct_to_template, {'template':'availability.xml','extra_context':{'deployurl':settings.DEPLOY_URL}}),
    #(r'^(?P<xsl>\w+)/capabilities$', direct_to_template, {'template':'capabilities.xml','extra_context':{'deployurl':settings.DEPLOY_URL}})
    )
