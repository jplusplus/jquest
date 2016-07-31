angular.module 'jquest'
  .provider 'favico', class FavicoProvider
    options: {}
    constructor: ->
      @setOptions animation: 'fade'
    setOptions: (options)=>
      angular.extend @options, options
    $get: =>
      @favico = new Favico @options
