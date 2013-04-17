from django.conf.urls.defaults import *

urlpatterns = patterns('webtools.views',
    (r'^recordtable$', 'recordVotable'),
    (r'^$', 'index'),
    
)
