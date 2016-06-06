angular.module 'jquest'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $urlRouterProvider.otherwise '/'
