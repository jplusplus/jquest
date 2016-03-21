#!/bin/bash

for SCRIPT in /app/.profile.d/*;
  do source $SCRIPT;
done

# Create, migrate DB
if bundle exec rake db:version | grep ": 0$"; then
  echo 'Creating database'
  bundle exec rake db:setup
else
  echo 'Migrating database'
  bundle exec rake db:migrate
fi

exec "$@"
