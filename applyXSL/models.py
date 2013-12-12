from django.db import models
from django.core.exceptions import ValidationError

class Conversion(models.Model):
    datetime = models.DateTimeField(auto_now_add=True)
    upload = models.FileField(upload_to='%x-%X',verbose_name='Input file',null=True, blank=True)
    url = models.URLField(max_length=1024, verbose_name='Input URL',null=True, blank=True)
    xsl = models.CharField(max_length=64)

#    def clean(self):
#        if (not (self.upload or self.url)) \
#            or (self.upload and self.url):
#            raise ValidationError('Give either input file or URL')
