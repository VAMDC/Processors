from django.conf.urls import url, include

urlpatterns = [
    url(r'^applyXSL/', include('applyXSL.urls')),
    url(r'^specsynth/', include('specsynth.urls')),
]

