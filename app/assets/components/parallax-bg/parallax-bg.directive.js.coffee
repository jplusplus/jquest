angular.module('jquest')
  .directive 'parallaxBg', ->
    'ngInject'
    restrict: 'A'
    scope:
      parallaxBg: "="
    link: (scope, element, attrs) ->
      # Shortcuts
      requestAF = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
      cancelAF = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
      # Initial position
      movedX = 0
      movedY = 0
      # Hold the animation frame request
      req = null
      # Target the background element
      target = angular.element element
      # Update background properties
      target.on "mousemove", (ev)->
        movedX = ev.pageX * - (scope.parallaxBg or 1/6)
        movedY = ev.pageY * - (scope.parallaxBg or 1/6)
        # Cancel aniexisting animation frame req
        cancelAF req
        # Then request the change
        req = requestAF ->
          # Function to update background on the current element
          target.css backgroundPosition: movedX + 'px ' + movedY + 'px'
