FROM alpine:3.2
RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake bash git \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs && \
    rm -rf /var/cache/apk/*
# Adds all the build dependencies as a virtual group named build-dependencies.
RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    openssl-dev postgresql-dev libc-dev linux-headers
# Fix trusted certificates erro
# @see https://gist.github.com/mislav/5026283
RUN curl https://curl.haxx.se/ca/cacert.pem -o "$(ruby -ropenssl -e 'puts OpenSSL::X509::DEFAULT_CERT_FILE')"
# Manage front dependencies with bower
RUN npm install bower -g --silent --progress=false
RUN gem install bundler
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
# Project root must be a git repository since many Gems use `git ls-files`
# @see https://github.com/bundler/bundler/issues/2039
RUN git init
# Copy Gemfile and install dependencies
COPY Gemfile* ./
# Second part installs bundler and runs bundle install command that installs all our application dependencies.
RUN bundle install --without development test && \
# After all gems are installed we finally remove virtual package group.
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
# Copy bower config
COPY .bowerrc bower.json ./
# Install packages before static precompilation
RUN bower install --production --silent --config.interactive=false
# Copy all file
ADD . .
# Update the crontab for automated jobs
RUN bundle exec whenever --update-crontab
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
