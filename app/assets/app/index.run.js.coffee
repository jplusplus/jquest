angular.module 'jquest'
  .run ($rootScope, Menu, CourseMaterials)->
    'ngInject'
    $rootScope.menu = Menu
    $rootScope.courseMaterials = CourseMaterials
