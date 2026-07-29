# Stage 1: Build Flutter Web app
FROM plugfox/flutter:3.19.0 AS build

WORKDIR /app

# Copy dependency configs and fetch packages
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy source code and build for web
COPY . .
RUN flutter build web --release

# Stage 2: Serve static files with Nginx
FROM nginx:alpine

# Copy built web artifacts to Nginx server root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]