angular.module 'jquest'
  .directive 'sticky', ($window)->
    restrict: 'AC'
    link: (scope, el)->
      # Internet Explorer 11
      unless document.documentMode?
        angular.element(el).addClass('sticky').Stickyfill()
