FROM django

RUN     apk update && apk upgrade
RUN     apk add \
                vim \
                apk-cron

ARG HOSTNAME=""

ENV HOSTNAME=${HOSTNAME}

WORKDIR /var/www/html

COPY ./api/mysite .
COPY ./api/requirements.txt .

COPY ./scripts/ /scripts

# Add crontab file
COPY ./scripts/root /etc/crontabs/root
# Give execution rights on the cron job
RUN chmod 0755 /etc/crontabs/root
# Create the log file
RUN touch /var/log/cron.log

RUN ["pip", "install", "--no-cache-dir", "--break-system-packages", "-r", "requirements.txt"]

ENTRYPOINT ["/scripts/run.sh"]