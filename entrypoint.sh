#!/bin/bash

# Running Database migrations
python manage.py migrate --noinput

# Run management command to create groups and permissions
# python manage.py createperms

# Running Application with uWSGI
exec uwsgi --module=sample.wsgi:application \
    --master \
    --http-socket=:9005 \
    --workers=4 \
    --processes=4 \
    --max-requests=1000 \
    --enable-threads \
    --vacuum \
    --log-4xx \
    --log-5xx \
    # --logto=$PWD/uwsgi.log \
"$@"