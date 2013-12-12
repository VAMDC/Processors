from django.conf.urls import patterns, url, include
from django.views.generic import TemplateView

urlpatterns = patterns('',
    url(r'^$', TemplateView.as_view(template_name='homepage.html'), name="home"),
)

from django.conf import settings

urlpatterns = patterns('applyXSL.views',
    (r'^(?P<xsl>\w+)/$', 'showForm'),
    (r'^(?P<xsl>\w+)/service$', 'receiveInput'),
    (r'^(?P<xsl>\w+)/result/(?P<rid>\w+)$', 'deliverResult'),
    (r'^(?P<xsl>\w+)/availability$', TemplateView.as_view(template_name='availability.xml')),
#    (r'^(?P<xsl>\w+)/capabilities$', direct_to_template, {'template':'capabilities.xml','extra_context':{'deployurl':settings.DEPLOY_URL}})
    )
