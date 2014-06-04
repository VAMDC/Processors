# -*- coding: utf-8 -*
from abc import ABCMeta, abstractmethod
from lxml import etree as e
from django.conf import settings
import commands
from urllib2 import urlopen
import tempfile

STATIC=settings.STATIC_DIR
SAXON_JAR = settings.SAXON_JAR

class XslTransformer(object):
    __metaclass__ = ABCMeta

    @abstractmethod
    def transform(self, form):
        pass
        
class XslTransformerFactory(object):
  @staticmethod
  def getXslTransformer(xslversion):
    if xslversion == 1 :
      return PythonXslTransformer()
    if xslversion == 2 :
      return SaxonXslTransformer()
      
    raise Exception("unsupported xsl version")

class SaxonXslTransformer(XslTransformer):
  def __init__(self):
    self.err = None    

  def transform(self, form):
    xslfile = STATIC+'/xsl/%s.xsl'%form.xsl
    try:
        if form.url:
          command = 'java -jar '+SAXON_JAR+' -s:"%s" -xsl:%s'%(form.url, xslfile)      
          output = commands.getoutput(command)
        elif form.upload:
          tmpfile = tempfile.NamedTemporaryFile(delete=False)
          xml = e.tostring(e.parse(form.upload))
          tmpfile.write(xml)
          tmpfile.flush()   # be sure that all data have been written 
          command = 'java -jar '+SAXON_JAR+' -s:"%s" -xsl:%s'%(tmp.name, xslfile)      
          output = commands.getoutput(command)
        else:
            self.err = '400 no data to transform\n'
    except Exception, exc:
        self.err = '400 input data seems to be broken XML\n'
        print exc
    
    if self.err:
        return self.err
    else:
        return output


class PythonXslTransformer(XslTransformer):
  def __init__(self):
    self.err = None
    
  # ConversionForm object
  def transform(self, form):
    xslfile = open(STATIC+'/xsl/%s.xsl'%form.xsl)
    xsl = e.XSLT(e.parse(xslfile))    

    try:
        if form.url:
          xml = e.parse(urlopen(form.url))
        elif form.upload:
          xml = e.parse(form.upload)
        else:
          self.err = '400 no data to transform\n'
    except Exception, exc:
        self.err = '400 input data seems to be broken XML\n'
        print exc

    try:
        output = str(xsl(xml))
    except:
        self.err = '500 transformation failed\n'

    if self.err:
        return self.err
    else:
        return output
