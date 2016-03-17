#!/bin/bash

for SCRIPT in /app/.profile.d/*;
  do source $SCRIPT;
done

# Create, migrate DB
if rake db:version | grep ": 0$"; then
  echo 'Creating database'
  rake db:setup
else
  echo 'Migrating database'
  rake db:migrate
fi

exec "$@"
