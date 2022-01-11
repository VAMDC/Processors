from django.conf.urls import url
from django.views.generic import TemplateView

from . import views
from django.conf import settings

class CapabilitiesView(TemplateView):
    template_name = 'capabilities.xml'
    def get_context_data(self, **kwargs):
        context = super(CapabilitiesView, self).get_context_data(**kwargs)
        context['deployurl'] = settings.DEPLOY_URL
        return context



urlpatterns = [
    url(r'^$', TemplateView.as_view(template_name='index.html'), name="home"),
    url(r'^(?P<xsl>\w+)/$', views.showForm),
    url(r'^(?P<xsl>\w+)/service$', views.receiveInput),
    url(r'^(?P<xsl>\w+)/result/(?P<rid>\w+)$', views.deliverResult),
    url(r'^(?P<xsl>\w+)/availability$', TemplateView.as_view(template_name='availability.xml')),
    url(r'^(?P<xsl>\w+)/capabilities$', CapabilitiesView.as_view()),
]
