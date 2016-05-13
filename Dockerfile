FROM heroku/cedar:14

RUN mkdir -p /app/user
WORKDIR /app/user

ENV GEM_PATH /app/heroku/ruby/bundle/ruby/2.2.0
ENV GEM_HOME /app/heroku/ruby/bundle/ruby/2.2.0
RUN mkdir -p /app/heroku/ruby/bundle/ruby/2.2.0

# Install Ruby
RUN mkdir -p /app/heroku/ruby/ruby-2.2.3
RUN curl -s --retry 3 -L https://heroku-buildpack-ruby.s3.amazonaws.com/cedar-14/ruby-2.2.3.tgz | tar xz -C /app/heroku/ruby/ruby-2.2.3
ENV PATH /app/heroku/ruby/ruby-2.2.3/bin:$PATH

# Install Node
RUN curl -s --retry 3 -L http://s3pository.heroku.com/node/v0.12.7/node-v0.12.7-linux-x64.tar.gz | tar xz -C /app/heroku/ruby/
RUN mv /app/heroku/ruby/node-v0.12.7-linux-x64 /app/heroku/ruby/node-0.12.7
ENV PATH /app/heroku/ruby/node-0.12.7/bin:$PATH

# Install Bundler
RUN gem install bundler -v 1.9.10 --no-ri --no-rdoc
ENV PATH /app/user/bin:/app/heroku/ruby/bundle/ruby/2.2.0/bin:$PATH
ENV BUNDLE_APP_CONFIG /app/heroku/ruby/.bundle/config

# Configure env
ENV RAILS_ENV production
ENV RACK_ENV production
ENV SECRET_KEY_BASE $(openssl rand -base64 32)

# export env vars during run time
RUN mkdir -p /app/.profile.d/
RUN echo "cd /app/user/" > /app/.profile.d/home.sh
# Copy ENV vars
RUN echo "export PATH=\"$PATH\":/app/user/bin/" > /app/.profile.d/ruby.sh
RUN echo "export GEM_PATH=\"$GEM_PATH\"" >> /app/.profile.d/ruby.sh
RUN echo "export GEM_HOME=\"$GEM_HOME\"" >> /app/.profile.d/ruby.sh
RUN echo "export RAILS_ENV=\"\${RAILS_ENV:-$RAILS_ENV}\"" >> /app/.profile.d/ruby.sh
RUN echo "export SECRET_KEY_BASE=\"\${SECRET_KEY_BASE:-$SECRET_KEY_BASE}\"" >> /app/.profile.d/ruby.sh
RUN echo "export BUNDLE_APP_CONFIG=\"$BUNDLE_APP_CONFIG\"" >> /app/.profile.d/ruby.sh

COPY ./init.sh /usr/bin/init.sh
RUN chmod +x /usr/bin/init.sh

ADD . /app/user
RUN chmod +x /app/user/init.sh
# Install bower and its dependencies
RUN npm install -g bower
RUN bower --allow-root install
# Run bundler to cache dependencies
RUN bundle install --path /app/heroku/ruby/bundle --without development:test --deployment --jobs 4
RUN bundle exec rake assets:precompile

ENTRYPOINT ["/usr/bin/init.sh"]
