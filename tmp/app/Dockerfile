FROM node:10 as base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production

FROM BASE as build
WORKDIR /usr/src/app
COPY . ./
RUN npm install

FROM BASE as production
WORKDIR /usr/src/app
COPY entrypoint.sh ./
COPY --from=build /usr/src/app/build ./build/
CMD ["./entrypoint.sh"]