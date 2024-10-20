# build stage

FROM node:lts-alpine as build-stage

ARG HOSTNAME=${HOSTNAME}
ENV HOSTNAME=${HOSTNAME}

WORKDIR /app
COPY ./front/front-end/package*.json ./
RUN npm install
COPY ./front/front-end/ .
RUN apk add envsubst


RUN [ "sh", "-c", "sed -i \"s/REPLACE_ME/$HOSTNAME/g\" ./src/jspong/main.js" ]

RUN [ "sh", "-c", "sed -i \"s/REPLACE_ME/$HOSTNAME/g\" ./src/components/game/PongComponent.vue" ]

RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
