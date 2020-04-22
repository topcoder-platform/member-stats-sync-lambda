FROM node:12-alpine

# Create app directory
WORKDIR /usr/src/app

RUN apk add --no-cache bash git curl

COPY package*.json ./
RUN npm i

COPY . .

EXPOSE 5210 4210 3000