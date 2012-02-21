from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('applyXSL.views',
    (r'^(?P<xsl>\w+)/$', 'showForm'),
    (r'^(?P<xsl>\w+)/service$', 'receiveInput'),
    (r'^(?P<xsl>\w+)/result/(?P<rid>\w+)$', 'deliverResult'),
    (r'^(?P<xsl>\w+)/availability$', direct_to_template, {'template':'availability.xml'} ),
    (r'^(?P<xsl>\w+)/capabilities$', direct_to_template, {'template':'capabilities.xml'})
    )
