# --- Web App build stage
FROM node:bookworm-slim AS build-stage

## Move to the working directory
WORKDIR /build

## Copy dependencies and build files
COPY package-lock.json package.json .lessrc /build

## Install dependencies
RUN npm ci

## Copy the project files
COPY app /build/app

## Compile the Web App
RUN npm run build:browser

# --- Web App deployment stage
FROM nginx:alpine

## Copy from build stage the built Web App
COPY --from=build-stage /build/dist-browser /usr/share/nginx/html
