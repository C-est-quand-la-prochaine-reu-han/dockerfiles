FROM nginx

ARG API_PORT=8000
ENV API_PORT=${API_PORT}

ARG PONG_PORT=8765
ENV PONG_PORT=${PONG_PORT}

COPY ./configuration/nginx.conf /etc/nginx/nginx.conf.template
RUN ["bash", "-c", "envsubst '$API_PORT $PONG_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf"]

