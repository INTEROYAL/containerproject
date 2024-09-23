# Use an official Nginx image as a base
FROM nginx:alpine

# Copy all website files from the current directory to the Nginx server
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
