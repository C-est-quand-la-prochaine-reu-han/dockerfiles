#!/bin/sh

python manage.py migrate
python manage.py loaddata production_data

exec uwsgi --ini /etc/uwsgi/uwsgi.ini
