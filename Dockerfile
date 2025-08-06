# Use the official Node.js runtime as the base image
FROM node:18-alpine

LABEL com.centurylinklabs.watchtower.enable="true"

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Create a non-root user to run the application
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Change ownership of the app directory to the nodejs user
RUN chown -R nodejs:nodejs /app
USER nodejs

# Expose the port your app runs on (adjust if different)
EXPOSE 3000

# Define the command to run your application
CMD ["node", "server.js"]