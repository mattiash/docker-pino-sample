FROM node:10 as base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production

FROM base as build
WORKDIR /usr/src/app
RUN npm install
COPY . ./
RUN npm run build

FROM build as notest
WORKDIR /usr/src/app
RUN rm -rf build/test

FROM base as production
WORKDIR /usr/src/app
COPY entrypoint.sh ./
COPY --from=notest /usr/src/app/build ./build/
CMD ["./entrypoint.sh"]
