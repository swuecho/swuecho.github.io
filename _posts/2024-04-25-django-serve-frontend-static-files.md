---
layout: post
title:  django serve frontend static files 
date:   2024-04-25 10:31 
categories: tech 
---

While it is not the best choices to serve static files using django in production, but for easy deployment for small or medium application, it is still useful.

Django configuration:

Follow the whitenoise tutorial:

https://whitenoise.readthedocs.io/en/stable/django.html

```py
# https://docs.djangoproject.com/en/3.2/howto/static-files/
STATIC_ROOT = BASE_DIR / "staticfiles"
STATIC_URL = "/static/"

# Simplified static file serving.
# https://warehouse.python.org/project/whitenoise/
STATICFILES_STORAGE = "whitenoise.storage.CompressedManifestStaticFilesStorage"
WHITENOISE_INDEX_FILE = True
```

```python
INSTALLED_APPS = [
    "whitenoise.runserver_nostatic",
    "django.contrib.staticfiles",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware",
    ...
]
```

In Vue frontend:

```diff
diff --git a/.env.production b/.env.production
index 9043edc..eeafc8f 100644
--- a/.env.production
+++ b/.env.production
@@ -2,7 +2,7 @@
 VITE_USE_HASH = 'false'
 
 # 资源公共路径,需要以 /开头和结尾
-VITE_PUBLIC_PATH = '/'
+VITE_PUBLIC_PATH = '/static'
```




