angular.module('jquest')
  .directive 'parallaxBg', ->
    'ngInject'
    restrict: 'A'
    scope:
      parallaxBg: "="
    link: (scope, element, attrs) ->
      angular.element(element).on "mousemove", (ev)->
        amountMovedX = ev.pageX * - (scope.parallaxBg or 1/6)
        amountMovedY = ev.pageY * - (scope.parallaxBg or 1/6)
        angular.element(@).css
          backgroundPosition: amountMovedX + 'px ' + amountMovedY + 'px'
