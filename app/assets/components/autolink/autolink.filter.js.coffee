angular.module 'jquest'
  .filter 'autolink', ->
    defaultOptions =
      truncate: 42
    (value, options={})->
      Autolinker.link value, angular.extend(options, defaultOptions)
