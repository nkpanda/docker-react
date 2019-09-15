# Use an existing docker image as base
FROM node:alpine as builder

WORKDIR '/app'

# Download and install a dependency
COPY package.json .
RUN npm install
COPY . .


# Tell the image what to do when it starts as a container
CMD ["npm", "run", "build"]


# New block for next process with new base image
FROM nginx


# Copy the build folder in web root
COPY --from=builder /app/build /usr/share/nginx/html

#nginex default command is start so no need to worry