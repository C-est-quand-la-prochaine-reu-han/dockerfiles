FROM django

ARG HOSTNAME=""

ENV HOSTNAME=${HOSTNAME}

WORKDIR /var/www/html

COPY ./api/mysite .
COPY ./api/requirements.txt .

COPY ./scripts/ /scripts

RUN ["pip", "install", "--no-cache-dir", "--break-system-packages", "-r", "requirements.txt"]

ENTRYPOINT ["/scripts/run.sh"]
