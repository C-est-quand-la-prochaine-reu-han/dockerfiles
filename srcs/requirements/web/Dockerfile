# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY ./front/front-end/package*.json ./
RUN npm install
COPY ./front/front-end/ .
RUN apk add envsubst
RUN cp ./src/jspong/main.js ./src/jspong/main.js.template
RUN [ "sh", "-c", "< ./src/jspong/main.js.template envsubst '$HOSTNAME' > ./src/jspong/main.js" ]
RUN cat ./src/jspong/main.js
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
