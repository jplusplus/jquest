FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
# Copy the current directory as /app
RUN mkdir -p /app
# Configure env
ENV PATH /app/bin:$PATH
ENV RAILS_ENV production
ENV RAILS_VERSION 4.2.6
ENV RACK_ENV production
ENV SECRET_KEY_BASE $(openssl rand -base64 32)
# Install rails and bower globaly
RUN gem install rails --version "$RAILS_VERSION"
RUN npm install -g bower

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install --without development:test --deployment --jobs 4
# Copy all file
ADD . /app
# Entrypoint script that setup or migrate db if needed
RUN chmod +x /app/bin/init
# Install bower and its dependencies
RUN bower --allow-root install
RUN bundle exec rake assets:precompile

ENTRYPOINT ["bash", "/app/bin/init"]
CMD ["bundle", "exec", "puma -C config/puma.rb"]
