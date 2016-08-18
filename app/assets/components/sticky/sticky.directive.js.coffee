angular.module 'jquest'
  .directive 'sticky', ($window)->
    restrict: 'AC'
    link: (scope, el)->
      unless /internet explorer/i.test $window.navigator.userAgent
        angular.element(el).addClass('sticky').Stickyfill()
