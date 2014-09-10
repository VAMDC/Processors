# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Spec',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('datetime', models.DateTimeField(auto_now_add=True)),
                ('upload', models.FileField(upload_to=b'%x-%X', null=True, verbose_name=b'Input file', blank=True)),
                ('url', models.URLField(max_length=1024, null=True, verbose_name=b'Input URL', blank=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
