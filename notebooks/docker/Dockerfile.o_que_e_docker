FROM node:20-alpine

WORKDIR /app

COPY . /app

CMD apt-get update -y

RUN node -v
RUN npm -b

ENTRYPOINT ["nodejs", "app.js"]
