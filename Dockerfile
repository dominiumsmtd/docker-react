FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

#Even though docker-compose will do the same thing, we still want this command be here,
#to allow use use this without docker-compose in the future
COPY . .

CMD npm run build

#/app/build <----all the stuff

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html