# Use a Node.js base image to handle Node.js operations like installing dependencies
FROM node:15

# Set the working directory in the Docker container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json into the working directory
COPY package*.json ./

# Install dependencies defined in package.json
RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Compile Sass to CSS using the script defined in package.json
RUN npm run sass

# Since this is a static site, use nginx to serve the content
# Use nginx stable alpine image
FROM nginx:stable-alpine

# Copy static assets from builder stage
COPY --from=0 /usr/src/app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx and keep the process running
CMD ["nginx", "-g", "daemon off;"]
