angular.module 'jquest'
  .run ($rootScope, Menu)->
    $rootScope.menu = Menu
