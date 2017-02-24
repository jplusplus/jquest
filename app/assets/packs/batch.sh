#!/bin/sh
for file in containers/main/season/*/*.js.coffee; do
    mv "$file" "`dirname $file`/`basename "$file" .js.coffee`.coffee"
done
