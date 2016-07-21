FROM ruby:2.3
RUN apt-get update && apt-get install -y nodejs npm --no-install-recommends
RUN apt-get update && apt-get install -y postgresql-client sqlite3 --no-install-recommends
RUN ln -s /usr/bin/nodejs /usr/bin/node
# Configure env
ENV PATH /usr/src/app/bin/:$PATH
ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_VERSION 4.2.6
ENV SECRET_KEY_BASE $(openssl rand -base64 32)
# Install rails and bower globaly
RUN gem install rails --version "$RAILS_VERSION"
# Switch to workdir
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# Copy Gemfile and install dependencies
COPY Gemfile* ./
RUN bundle install
# Copy all file
ADD . .
# Prevente a bug with bundler
RUN git init
# Manage front dependencies with bower
RUN npm install bower -g
# This will prepare every assets, download dependencies
# with bower and annotate angular DI
RUN bundle exec rake assets:precompile
# Switch to non-root- user
RUN useradd -ms /bin/bash jquest
RUN chown -R jquest /usr/src/app
USER jquest

# Entrypoint script that setup or migrate db if needed
# RUN chmod +x /usr/src/app/bin/init
# ENTRYPOINT ["/usr/src/app/bin/init"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
