FROM nginx

ARG HOSTNAME=localhost
ENV HOSTNAME=${HOSTNAME}

ARG API_PORT=8000
ENV API_PORT=${API_PORT}

ARG PONG_PORT=8765
ENV PONG_PORT=${PONG_PORT}

EXPOSE 443

RUN mkdir -p /etc/ssl/private
RUN chmod 700 /etc/ssl/private
RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 -subj="/C=/ST=/L=/O=/CN=${HOSTNAME}" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
RUN chown 101:101 -R /etc/ssl/private

COPY ./configuration/nginx.conf /etc/nginx/nginx.conf.template

RUN ["bash", "-c", "envsubst '$API_PORT $PONG_PORT $HOSTNAME' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf"]

