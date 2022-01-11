# -*- coding: utf-8 -*
from abc import ABCMeta, abstractmethod
from lxml import etree as e
from django.conf import settings
import subprocess
from urllib.request import urlopen
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
    import os.path
    try:
        if form.url:
          command = ['java', '-jar', SAXON_JAR, '-s:"{form.url}"'.format(form.url),  '-xsl:{}'.format(xslfile)]
          output = subprocess.check_output(' '.join(command), encoding="UTF-8")
        elif form.upload:
          with tempfile.NamedTemporaryFile(delete=True) as tmpfile:
            xml = e.tostring(e.parse(form.upload))
            tmpfile.write(xml)
            tmpfile.flush()   # be sure that all data have been written 
            command = ['java', '-jar', SAXON_JAR, '-s:%s'%(tmpfile.name),  '-xsl:{}'.format(xslfile)]
            output = subprocess.check_output(command, encoding="UTF-8")
        else:
            self.err = '400 no data to transform\n'
    except Exception as exc:
        self.err = '400 input data seems to be broken XML\n'
        print(exc)
    
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
    except Exception as exc:
        self.err = '400 input data seems to be broken XML\n'
        print(exc)

    try:
        output = str(xsl(xml))
    except:
        self.err = '500 transformation failed\n'

    if self.err:
        return self.err
    else:
        return output
