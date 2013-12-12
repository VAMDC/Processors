from django.conf.urls import patterns, url, include
from django.views.generic import TemplateView

urlpatterns = patterns('',
    url(r'^$', TemplateView.as_view(template_name='homepage.html'), name="home"),
)

from django.conf import settings

class CapabilitiesView(TemplateView):
    template_name = 'capabilities.xml'
    def get_context_data(self, **kwargs):
        context = super(CapabilitiesView, self).get_context_data(**kwargs)
        context['deployurl'] = settings.DEPLOY_URL
        return context



urlpatterns = patterns('applyXSL.views',
    (r'^(?P<xsl>\w+)/$', 'showForm'),
    (r'^(?P<xsl>\w+)/service$', 'receiveInput'),
    (r'^(?P<xsl>\w+)/result/(?P<rid>\w+)$', 'deliverResult'),
    (r'^(?P<xsl>\w+)/availability$', TemplateView.as_view(template_name='availability.xml')),
    url(r'^(?P<xsl>\w+)/capabilities$', CapabilitiesView.as_view()),
    )
