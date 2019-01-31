# Build the project phase
FROM node:alpine as builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
# Exports port 80
EXPOSE 80
# Copy build directory from phase builder to this container nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html
# Nginx default cmd will start this for us
