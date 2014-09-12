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

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.7/howto/deployment/checklist/
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '9bm-4r0^s%zx2gpql_alnwecf5!03r&9^$jsplui($9n_r)o^s'

DEBUG = True
TEMPLATE_DEBUG = DEBUG
ALLOWED_HOSTS = []

TIME_ZONE = 'Europe/Stockholm'
LANGUAGE_CODE = 'en-us'
USE_I18N = False
USE_L10N = False
USE_TZ = False

ROOT_URLCONF = 'processors.urls'
WSGI_APPLICATION = 'processors.wsgi.application'

# Database
# https://docs.djangoproject.com/en/1.7/ref/settings/#databases
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'processors.db',
    }
}

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.7/howto/static-files/
STATIC_URL = '/static/'
STATIC_DIR = '/home/tom/work/vamdc/Processors/static'
#MEDIA_ROOT='/tmp/webtools'
#MEDIA_URL='http://localhost:8000/result/'

TEMPLATE_DIRS = (
    '/home/tom/work/vamdc/Processors/templates',
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    #'django.contrib.sessions',
    #'django.contrib.messages',
    #'django.contrib.staticfiles',
    #'django.contrib.sites',
    #'django.contrib.admin',
    #'django.contrib.admindocs',
    'applyXSL',
    'corsheaders',
    'specsynth',
)

MIDDLEWARE_CLASSES = (
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.common.CommonMiddleware',
    #'django.contrib.sessions.middleware.SessionMiddleware',
    #'django.middleware.csrf.CsrfViewMiddleware',
    #'django.contrib.auth.middleware.AuthenticationMiddleware',
    #'django.contrib.messages.middleware.MessageMiddleware',
)

CORS_ORIGIN_ALLOW_ALL = True

# List of callables that know how to import templates from various sources.
#TEMPLATE_LOADERS = (
#    'django.template.loaders.filesystem.Loader',
#    'django.template.loaders.app_directories.Loader',
#)
