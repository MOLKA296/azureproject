Dockerfile : 
FROM node:20 AS build 
 
ENV NODE_OPTIONS=--openssl-legacy-provider 
 
WORKDIR /app 
 
COPY package.json package-lock.json ./ 
 
RUN npm install  # Installe les dépendances 
 
COPY . . 
 
RUN npm run build -- --configuration=production --verbose 
 
RUN ls -l /app 
 
RUN ls -l /app/dist/angular-app 
 
FROM nginx:alpine 
 
COPY --from=build /app/dist/angular-app /usr/share/nginx/html 
 
EXPOSE 80 
 
CMD ["nginx", "-g", "daemon off;"] 
 
