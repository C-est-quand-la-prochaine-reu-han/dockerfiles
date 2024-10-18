#!/bin/sh

python manage.py migrate
python manage.py loaddata data_final
# python manage.py loaddata data_all


crond -l 2 &
uwsgi --ini /etc/uwsgi/uwsgi.ini &

chmod 777 -R /var/www/html

trap "
	echo 'shutting down...'
	kill %1
	kill %2
" INT

wait %2
kill %1
