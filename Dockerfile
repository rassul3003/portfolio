# Use an official Node.js runtime as a base image
FROM node:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install any dependencies
RUN npm init & install node-sass
RUN npm start sass

# Copy the entire project
COPY . .

# Build the project if necessary
RUN npm run build

# Your application will be running on port 3000
EXPOSE 3000

# Run your app
CMD ["node", "server.js"] # Replace 'server.js' with your Node.js server file
