angular.module 'jquest'
  .directive 'sticky', ->
    restrict: 'AC'
    link: (scope, el)->
      angular.element(el).addClass('sticky').Stickyfill()
