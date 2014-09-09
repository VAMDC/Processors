from django.conf.urls.defaults import *
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    #(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    #(r'^admin/', include(admin.site.urls)),
    #(r'^query/', include('query.urls')),
    (r'^applyXSL/', include('applyXSL.urls')),
    (r'^specsynth/', include('specsynth.urls')),
    (r'^$', include('webtools.urls')),
)
