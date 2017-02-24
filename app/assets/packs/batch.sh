for file in *.js.coffee; do
    mv "$file" "`basename "$file" .js.coffee`.coffee"
done
