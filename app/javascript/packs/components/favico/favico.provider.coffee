Favico = require 'favico.js'

module.exports = class FavicoProvider
  options: {}
  constructor: ->
    @setOptions animation: 'fade'
  setOptions: (options)=>
    angular.extend @options, options
  $get: =>
    @favico = new Favico @options
