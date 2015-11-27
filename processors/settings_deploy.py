"""
Django settings for processors project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))

DEBUG = False
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ('Thomas Marquart', 'thomas@marquart.se'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'processors.db',
    }
}

ROOT_URLCONF = 'processors.urls'
WSGI_APPLICATION = 'processors.wsgi.application'
ALLOWED_HOSTS=['*']

TEMPLATE_DIRS = (
    '/opt/VamdcProcessors/templates',
)

STATIC_DIR = '/opt/VamdcProcessors/static'
STATIC_URL = '/'
SERVER_EMAIL = 'vamdc@vald.astro.uu.se'
DEPLOY_URL = 'http://vamdc.tmy.se/12.07/'

INSTALLED_APPS = (
    'django.contrib.contenttypes',
    'applyXSL',
    'specsynth',
)

MEDIA_ROOT='/tmp/webtools'
TIME_ZONE = 'Europe/Stockholm'
USE_I18N = False
USE_L10N = False
USE_TZ = False

#ADMIN_MEDIA_PREFIX = '/admin-media/'
SECRET_KEY = '=4ne456erg5_v3p@gin!bgp*oh2_t@(_hfdsfgew5y74!!za27g1&_r4j3(2!+i1'


MIDDLEWARE_CLASSES = (
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
)
CORS_ORIGIN_ALLOW_ALL = True

