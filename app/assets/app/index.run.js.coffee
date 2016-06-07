angular.module 'jquest'
  .run ($rootScope, Menu)->
    'ngInject'
    $rootScope.menu = Menu
