angular.module 'jquest'
  .directive 'flatpickr', ->
    restrict: 'AC'
    link: (scope, element, attr)->
      flatpickr element[0]
