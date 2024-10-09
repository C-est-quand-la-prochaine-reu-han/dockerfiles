#!/bin/sh

python manage.py migrate
python manage.py loaddata data_all

exec uwsgi --ini /etc/uwsgi/uwsgi.ini
