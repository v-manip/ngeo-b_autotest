#-------------------------------------------------------------------------------
#
# Project: ngEO Browse Server <http://ngeo.eox.at>
# Authors: Fabian Schindler <fabian.schindler@eox.at>
#          Marko Locher <marko.locher@eox.at>
#          Stephan Meissl <stephan.meissl@eox.at>
#
#-------------------------------------------------------------------------------
# Copyright (C) 2012 EOX IT Services GmbH
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies of this Software or works derived from this Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-------------------------------------------------------------------------------

"""
Django settings for ngEO Browse Server's autotest instance.

"""
from os.path import join

PROJECT_DIR = '/var/ngeob_autotest'
PROJECT_URL_PREFIX = ''

#TEST_RUNNER = 'eoxserver.testing.core.EOxServerTestRunner'

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    # ('EOX', 'office@eox.at'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'NAME': 'ngeo_browse_server_db',
        'USER': 'ngeo_user',
        'PASSWORD': 'oi4Zuush',
    },
    'mapcache': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/var/ngeob_autotest/data/mapcache.sqlite',
        'TEST_NAME': '/var/ngeob_autotest/data/test_mapcache.sqlite',
    }
}

DATABASE_ROUTERS = ['ngeo_browse_server.dbrouters.MapCacheRouter', ]

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# In a Windows environment this must be set to your system time zone.
# Note that this is the time zone to which Django will convert all
# dates/times -- not necessarily the timezone of the server.
# If you are using UTC (Zulu) time zone for your data (e.g. most
# satellite imagery) it is highly recommended to use 'UTC' here. Otherwise
# you will encounter time-shifts between your data, search request & the 
# returned results.
TIME_ZONE = 'UTC'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale.
USE_L10N = True

# If you set this to False, Django will not use timezone-aware datetimes.
USE_TZ = True

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = ''

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = join(PROJECT_DIR, 'static')

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

# Additional locations of static files
STATICFILES_DIRS = (
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'e2#pl-esv$q6g84mw8v9&amp;!(2rx$m(pi2%=$sdgj@(f(rqommr4'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
#     'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
# Commented because of POST requests:    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    # Uncomment the next line for simple clickjacking protection:
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',

    # For management of the per/request cache system.
    'eoxserver.backends.middleware.BackendsCacheMiddleware',
)

ROOT_URLCONF = 'urls'

# Python dotted path to the WSGI application used by Django's runserver.
WSGI_APPLICATION = 'wsgi.application'

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.gis',
    'django.contrib.staticfiles',
    # Enable the admin:
    'django.contrib.admin',
    # Enable admin documentation:
    'django.contrib.admindocs',
#    'django.contrib.databrowse',
#    'django_extensions',
    # Enable EOxServer:
    'eoxserver.core',
    'eoxserver.services',
    'eoxserver.resources.coverages',
    'eoxserver.resources.processes',
    'eoxserver.backends',
    'eoxserver.testing',
    'eoxserver.webclient',
    # Enable ngEO Browse Server:
    'ngeo_browse_server.config',
    'ngeo_browse_server.control',
    'ngeo_browse_server.mapcache',
    'vmanip_server.mesh_factory',
    'vmanip_server.mesh_cache',
)

# The configured EOxServer components. Components add specific functionality
# to the EOxServer and must adhere to a given interface. In order to activate 
# a component, its module must be included in the following list or imported at
# some other place. To help configuring all required components, each module 
# path can end with either a '*' or '**'. The single '*' means that all direct
# modules in the package will be included. With the double '**' a recursive 
# search will be done.
COMPONENTS = (
    'eoxserver.backends.storages.*',
    'eoxserver.backends.packages.*',
    'eoxserver.resources.coverages.metadata.formats.*',
    'eoxserver.services.ows.wcs.**',
    'eoxserver.services.ows.wms.**',
    'eoxserver.services.mapserver.**',
    'vmanip_server.mesh_factory.ows.w3ds.**',
    'vmanip_server.mesh_cache.ows.w3ds.**',
)


LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'formatters': {
        'simple': {
            'format': '%(levelname)s: %(message)s'
        },
        'verbose': {
            'format': '[%(asctime)s][%(module)s] %(levelname)s: %(message)s'
        }
    },
    'handlers': {
        'eoxserver_file': {
            'level': 'DEBUG',
            'class': 'logging.handlers.WatchedFileHandler',
            'filename': join(PROJECT_DIR, 'logs', 'eoxserver.log'),
            'formatter': 'verbose' if DEBUG else 'simple',
            'filters': [],
        },
        'ngeo_file': {
            'level': 'DEBUG',
            'class': 'logging.handlers.WatchedFileHandler',
            'filename': join(PROJECT_DIR, 'logs', 'ngeo.log'),
            'formatter': 'verbose' if DEBUG else 'simple',
            'filters': [],
        }
    },
    'loggers': {
        'eoxserver': {
            'handlers': ['eoxserver_file'],
            'level': 'DEBUG' if DEBUG else 'INFO',
            'propagate': False,
        },
        'ngeo_browse_server': {
            'handlers': ['ngeo_file'],
            'level': 'DEBUG' if DEBUG else 'INFO',
            'propagate': False,
        },
    }
}

FIXTURE_DIRS = (
    join(PROJECT_DIR, 'data/fixtures'),
)

# Set this variable if the path to the instance cannot be resolved 
# automatically, e.g. in case of redirects
#FORCE_SCRIPT_NAME="/path/to/instance/"
