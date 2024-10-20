FROM django

RUN	 apk update && apk upgrade
RUN	 apk add \
		vim \
		apk-cron

ARG HOSTNAME=""
ARG BOT_TOKEN=""

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

RUN ["sh", "-c", "sed -i \"s/REPLACE_WITH_BOT_KEY/$BOT_TOKEN/g\" /var/www/html/appong/fixtures/data_final.json" ]

RUN ["pip", "install", "--no-cache-dir", "--break-system-packages", "-r", "requirements.txt"]

ENTRYPOINT ["/scripts/run.sh"]
