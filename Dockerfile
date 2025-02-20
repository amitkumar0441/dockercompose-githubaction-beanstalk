# STAGE 01: Build Stage
FROM node:20 AS builder
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm ci --only=production  # Faster & avoids unnecessary dev dependencies

# Copy source files and build the project
COPY . .
RUN npm run build

# STAGE 02: Serve with Nginx
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Copy build artifacts from builder stage
COPY --from=builder /app/build . 

# Expose port 80
EXPOSE 80


