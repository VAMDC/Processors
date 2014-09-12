from django.conf.urls import patterns, include, url
#from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'processors.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    # url(r'^admin/', include(admin.site.urls)),

    url(r'^applyXSL/', include('applyXSL.urls')),
    url(r'^specsynth/', include('specsynth.urls')),
)
