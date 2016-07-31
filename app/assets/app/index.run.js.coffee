angular.module 'jquest'
  .run ($rootScope, Menu, CourseMaterials, favico)->
    'ngInject'
    # Global scope attribute
    $rootScope.menu = Menu
    $rootScope.courseMaterials = CourseMaterials
    # Are we in production
    if -1 is location.hostname.indexOf 'jquestapp.com'
      # Configure favico
      favico.badge "#"
