
# syntax=docker/dockerfile:1

# Use the latest Node.js version as the base image
FROM node:16

# Set the environment variable to production
ENV NODE_ENV=production

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY ["package.json", "package-lock.json*", "./"]

# Run the npm install command to install the production dependencies
# Commented out the previous line and added lines for Apt package manager installation and updates
# Install necessary dependencies for building native dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    python2.7 \
    build-essential \
    && ln -s /usr/bin/python2.7 /usr/bin/python

# Commented out the previous line and added line for installing npm packages using \`npm ci\`
# Fixed typo in the command from \`npm install\` to \`npm ci\` as it installs packages according to the lock file
RUN npm ci --only=production

# Copy the remaining files to the working directory
COPY . .

# Expose port 3000 for accessing the application
EXPOSE 3000

# Start the application
CMD [ "node", "index.js" ]
