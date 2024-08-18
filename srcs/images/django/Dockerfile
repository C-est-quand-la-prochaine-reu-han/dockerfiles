# WSGI_FILE : file used as the app to run, passed to uwsgi --module option
# PORT : Port on which the app is exposed
# APP_DIR : Path of the app on the host machine. It will be mounted on /var/www/html in the container

FROM alpine:latest

EXPOSE ${PORT}

WORKDIR /var/www/html
COPY configuration/test.py /var/www/html/test.py

RUN adduser uwsgi -S -D -H -s /usr/sbin/nologin ; \
	apk add python3 python3-dev py3-pip gcc musl-dev linux-headers ; \
	pip install --break-system-packages uwsgi django

ENTRYPOINT uwsgi --uid uwsgi --logto=/var/log/uwsgi.log --http-socket 0.0.0.0:$PORT --module $WSGI_FILE --master --processes 4 --threads 2
