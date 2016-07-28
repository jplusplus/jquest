angular.module('jquest')
  .directive 'fullscreenHeight', ($window) ->
    'ngInject'
    restrict: 'A'
    link: (scope, element, attrs) ->
      # Declare and call a function to resize the directive element
      do resize = ->
        unless isNaN(attrs.fullscreenHeight)
          element.css 'min-height', Math.max(attrs.fullscreenHeight, $window.innerHeight)
        else
          element.css('min-height', $window.innerHeight + 'px')
      # Create a uniq event id for this directive
      ev = 'resize.fullscreen-' + _.uniqueId()
      # Bind this event to window resize
      angular.element($window).bind ev, resize
      # Destory this event when destroying this directive's scope
      scope.$on '$destroy', -> angular.element($window).unbind ev
