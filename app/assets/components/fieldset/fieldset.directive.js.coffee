angular.module 'jquest'
  .directive 'fieldset', ->
    restrict: 'E'
    link: (scope, element, attrs) ->
      # Only watch if the browser doesn't support disabled on fieldsets
      if angular.isUndefined( element.prop 'disabled' )
        # Watch for changes on disable attribute
        scope.$watch (-> element.attr 'disabled' ), (disabled)->
          # Propagate the same state on child inputs
          element.find('input, select, textarea').prop 'disabled', disabled
