from django.conf.urls.defaults import *

urlpatterns = patterns('applyXSL.views',
    (r'^(?P<xsl>\w+)/$', 'receiveData'),
    (r'^result/(?P<rid>\w+)', 'deliverResult')
    )
