#!/bin/sh

python manage.py migrate
# python manage.py loaddata data_all
python manage.py loaddata data_final

crond -b -l 2
exec uwsgi --ini /etc/uwsgi/uwsgi.ini
