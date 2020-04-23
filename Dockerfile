# --- build phase ---
# refer to node:alpine as builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install

# No need for the volume system because this is for production
COPY . .
RUN npm run build

# --- run phase ---
# /app/build <--- will contain all the stuff from the build phase that we care
# about. The FROM directive initiates a new build "phase".
FROM nginx

# copy from the "builder phase". the /app/build was populated by the COPY cmd
# in the build phase above.
COPY --from=builder /app/build /usr/share/nginx/html

# The default command of the nginx image is to startup nginx.

