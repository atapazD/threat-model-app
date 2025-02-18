#This uses a node.js base image to build the app AS builder
FROM node:18 AS builder

#Sets the working directory inside the container
WORKDIR /app

#copys package.json and package-lock.json to leverage Docker caching
COPY package.json package-lock.json ./

# Installs the dependencies
RUN npm install --force

# Copy the rest of the application files from current path to WORKDIR which is /app
COPY . .

# Builds the React App
RUN npm run build

# Use an Nginx image to serve the built app
FROM nginx:latest

# Copies the built React app a from the /app/build directory into the nginx /usr/share/nginx/html directoryh
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 3000
EXPOSE 3000

# Starts the Nginx server in the foreground
CMD [ "nginx", "-g", "daemon off;" ]