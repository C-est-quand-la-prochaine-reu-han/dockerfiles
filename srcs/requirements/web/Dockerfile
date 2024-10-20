# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY ./front/front-end/package*.json ./
RUN npm install
COPY ./front/front-end/ .
RUN apk add envsubst
RUN cp ./src/jspong/main.js ./src/jspong/main.js.template
RUN cp ./src/components/game/PongComponent.vue ./src/components/game/PongComponent.vue.template
RUN [ "sh", "-c", "< ./src/jspong/main.js.template envsubst '$HOSTNAME' > ./src/jspong/main.js" ]
RUN [ "sh", "-c", "< ./src/components/game/PongComponent.vue.template envsubst '$HOSTNAME' > ./src/components/game/PongComponent.vue" ]
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
