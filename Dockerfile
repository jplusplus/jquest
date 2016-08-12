FROM alpine:3.2
RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake git bash \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs
# Configure env
ENV PATH /usr/src/app/bin/:$PATH
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_VERSION 4.2.6
ENV SECRET_KEY_BASE $(openssl rand -base64 32)
# Switch to workdir
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# Copy Gemfile and install dependencies
COPY Gemfile* ./
# First part adds all the build dependencies as a virtual group named build-dependencies.
RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    postgresql-dev libc-dev linux-headers && \
# Second part installs bundler and runs bundle install command that installs all our application dependencies.
    gem install bundler && \
    cd /app ; bundle install --without development test && \
# After all gems are installed we finally remove virtual package group.
    apk del build-dependencies
# Manage front dependencies with bower
RUN npm install bower -g
# Copy all file
ADD . .
# Prevente a bug with bundler
RUN git init
# This will prepare every assets, download dependencies
# with bower and annotate angular DI
RUN bundle exec rake assets:precompile
# Switch to non-root- user
RUN chown -R nobody:nogroup /usr/src/app
USER nobody
# Entrypoint script that setup or migrate db if needed
RUN chmod +x /usr/src/app/bin/*
# ENTRYPOINT ["/usr/src/app/bin/init"]
CMD /usr/src/app/bin/web
