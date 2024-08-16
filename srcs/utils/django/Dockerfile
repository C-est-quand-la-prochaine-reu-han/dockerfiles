FROM alpine:latest

EXPOSE 8080

WORKDIR /var/www/html
COPY configuration/test.py /var/www/html/test.py

RUN adduser uwsgi -S -D -H -s /usr/sbin/nologin
RUN apk add python3 python3-dev py3-pip gcc musl-dev linux-headers
RUN pip install --break-system-packages uwsgi

ENTRYPOINT uwsgi --uid uwsgi --http 0.0.0.0:8080 --wsgi-file test.py
