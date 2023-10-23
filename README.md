# Docker CLI

  ## Build a image from Dockerfile
    docker build -t my-todo-app .

  ## Run container out of a image
    docker run -dp 3000:3000 my-todo-app

  ## Check containers
    docker ps [Note: displays running containers only]
    docker ps --all

  ## Command to stop/remove containers
    docker stop container-name/container-id
    docker rm container-name/container-id

    docker rm container-name/container-id -f

  ## Create ubuntu container
    docker run -it ubuntu bin/bash
    echo content_here > filename
    cat filename

  ## Install NodeJS and NPM in Ubuntu container
    curl https://nodejs.org/dist/v20.8.1/node-v20.8.1-linux-x64.tar.xz | tar -xJ -C /usr/local/lib/nodejs --strip-components=1
  
  This installs nodejs in the `usr/local/lib` directory. We need to add this to the system path.
    
    echo 'export PATH="/usr/local/lib/nodejs/bin:$PATH"' | tee -a ~/.profile
    source ~/.profile
    cat ~/.profile

  ## NodeJS Dockerfile
    FROM node:21-alpine
    WORKDIR /my-app
    COPY . .
    RUN npm install
    CMD ["node", "src/index.js"]
    EXPOSE 3000

  ## Ubuntu with NodeJS installed Dockerfile
    FROM ubuntu:latest

    ENV NODE_VERSION=20.8.1 NODE_DISTRO=linux-x64

    WORKDIR /

    RUN mkdir -p /usr/local/lib/nodejs

    RUN apt update && apt install -y curl xz-utils

    RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_DISTRO}.tar.xz | tar -xJ -C /usr/local/lib/nodejs --strip-components=1

    ENV PATH="/usr/local/lib/nodejs/bin:$PATH"
    
    CMD ["bash"]

  ## Bind mounting on Ubuntu with NodeJS installed container
    docker run -p 3000:3000 -it --mount type=bind,src=$(pwd),target=/app/todo-node ubuntu-with-node
