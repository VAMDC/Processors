from django.views.generic import TemplateView
from django.conf.urls import url, include

urlpatterns = [
    url(r'^applyXSL/', include('applyXSL.urls')),
    url(r'^specsynth/', include('specsynth.urls')),
    url(r'^$', TemplateView.as_view(template_name='index.html'), name="home"),
]

