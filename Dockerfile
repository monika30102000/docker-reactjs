# Build environment
FROM node:9.6.1 AS builder

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Set environment variables (corrected format)
ENV PATH=/usr/src/app/node_modules/.bin:$PATH

# Install app dependencies
COPY package.json /usr/src/app/package.json
RUN npm install --silent
RUN npm install react-scripts@1.1.1 -g --silent

# Copy app source code
COPY . /usr/src/app

# Build the app
RUN npm run build


# Production environment
FROM nginx:1.13.9-alpine

# Copy built assets from builder stage
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# Expose port for the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

