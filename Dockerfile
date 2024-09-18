# Stage 1: Build the Angular app
FROM node:16 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install @angular/cli@8.3.29
COPY . .
RUN npx ng build --prod

# Stage 2: Serve the Angular app with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/angular-8-example-app /usr/share/nginx/html
# EXPOSE 80 8000
CMD ["nginx", "-g", "daemon off;"]


