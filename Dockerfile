FROM alpine:3.2
RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake bash git \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs && \
    rm -rf /var/cache/apk/*
# Manage front dependencies with bower
RUN npm install bower -g
# Configure env
ENV PATH /usr/src/app/bin/:$PATH
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_VERSION 4.2.6
# Create a secret key dynamicly.
# Files in /etc/profile.d/ that end by .sh are loaded automaticly
RUN bash -l -c 'echo export SECRET_KEY_BASE="$(openssl rand -hex 64)" > /etc/profile.d/docker.sh'
# Switch to workdir
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# Copy Gemfile and install dependencies
COPY Gemfile* ./
# Adds all the build dependencies as a virtual group named build-dependencies.
RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    openssl-dev postgresql-dev libc-dev linux-headers && \
# Project root must be a git repository since many Gems use `git ls-files`
# @see https://github.com/bundler/bundler/issues/2039
    git init && \
# Second part installs bundler and runs bundle install command that installs all our application dependencies.
    gem install bundler && \
    bundle install --without development test && \
# After all gems are installed we finally remove virtual package group.
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
# Copy all file
ADD . .
# This will prepare every assets, download dependencies
# with bower and annotate angular DI
RUN bundle exec rake assets:precompile
# Switch to non-root- user
RUN chown -R nobody:nogroup /usr/src/app
USER nobody
# Entrypoint script that setup or migrate db if needed
RUN chmod +x /usr/src/app/bin/*
# Entrypoint must be a login shell to load .profile
# ENTRYPOINT ["/bin/sh", "-l", "-c"]
CMD /usr/src/app/bin/web
