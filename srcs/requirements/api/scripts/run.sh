#!/bin/sh

python manage.py migrate
python manage.py loaddata data_all

crond -b -l 2
exec uwsgi --ini /etc/uwsgi/uwsgi.ini
