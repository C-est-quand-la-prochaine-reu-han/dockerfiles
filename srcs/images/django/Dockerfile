# WSGI_FILE : file used as the app to run, passed to uwsgi --module option
# PORT : Port on which the app is exposed
# APP_DIR : Path of the app on the host machine. It will be mounted on /var/www/html in the container

FROM alpine:latest

EXPOSE ${PORT}

WORKDIR /var/www/html
COPY configuration/test.py /var/www/html/test.py

RUN adduser uwsgi -S -D -H -s /usr/sbin/nologin
RUN apk add python3 python3-dev py3-pip gcc musl-dev linux-headers
RUN pip install --break-system-packages uwsgi django

ENTRYPOINT echo uwsgi --uid uwsgi --http 0.0.0.0:$PORT --module $WSGI_FILE; ls /var/www/html/$WSGI_FILE; uwsgi --uid uwsgi --http 0.0.0.0:$PORT --module $WSGI_FILE
