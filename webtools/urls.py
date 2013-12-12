from django.conf.urls import patterns, include, url

urlpatterns = patterns('webtools.views',
    (r'^$', 'index'),
    )
