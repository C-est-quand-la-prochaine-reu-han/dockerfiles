# WSGI_FILE : file used as the app to run, passed to uwsgi --module option
# PORT : Port on which the app is exposed
# APP_DIR : Path of the app on the host machine. It will be mounted on /var/www/html in the container

FROM alpine:latest

COPY configuration/ /etc/uwsgi/

RUN mkdir -p /etc/uwsgi ; \
	adduser uwsgi -S -D -H -s /usr/sbin/nologin ; \
	apk add python3 python3-dev py3-pip gcc musl-dev linux-headers ; \
	pip install --break-system-packages uwsgi django

EXPOSE ${PORT}

ENTRYPOINT ["uwsgi", "--ini", "/etc/uwsgi/uwsgi.ini"]
