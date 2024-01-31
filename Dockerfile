FROM public.ecr.aws/docker/library/node:20-alpine AS node

# Set up a non-root user and directory
RUN addgroup -g 10001 -S app 
RUN adduser -S -D -G app -u 10001 app
RUN mkdir /usr/app
WORKDIR /usr/app

# Copy the code in
COPY . .

# Build the thing
RUN npm i

# Switch to non-root user
RUN chown -R app:app /usr/app
USER app
RUN rm -rf /usr/app/config && ln -s /config /usr/app/config
# Node API setup
CMD ["node", "index.js"]
