FROM node:lts-alpine AS builder
WORKDIR '/app'
COPY package.json package-lock.json ./
RUN npm install
COPY ./ ./
RUN npm run build-prod

FROM nginx:stable-alpine
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/eventhorizonlabseu/ /usr/share/nginx/html
