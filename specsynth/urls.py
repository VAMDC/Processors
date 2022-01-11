from django.conf.urls import url, include

from specsynth import views

urlpatterns = [
    url(r'^$', views.showForm),
    url(r'service$', views.receiveInput),
    url(r'result/spec_(?P<rid>\w+).json$', views.deliverResult),
    #(r'^(?P<xsl>\w+)/availability$', direct_to_template, {'template':'availability.xml','extra_context':{'deployurl':settings.DEPLOY_URL}}),
    #(r'^(?P<xsl>\w+)/capabilities$', direct_to_template, {'template':'capabilities.xml','extra_context':{'deployurl':settings.DEPLOY_URL}})
    
]

