# Step one is to build the production grade application
# tagging node:alpine as builder name
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# Second step is to take th build app and run it
# FROM statement marks the start of new step
FROM nginx
# this tas is when used to deploy in aws elastic bean to expose this port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

