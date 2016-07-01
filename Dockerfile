FROM rails:onbuild
# We need NPM to install bower
RUN apt-get update && apt-get install -y npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
# Configure env
ENV PATH /usr/src/app:$PATH
ENV RACK_ENV production
ENV RAILS_ENV production
ENV SECRET_KEY_BASE $(openssl rand -base64 32)

# Prevente a bug with bundler
RUN git init
# Manage front dependencies with bower
RUN npm install bower -g
# This will compile every assets, download dependencies with bower,
# annotate angular DI and compress every files
RUN bundle exec rake assets:precompile

# ENTRYPOINT ["bash", "/usr/src/app/bin/init"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
