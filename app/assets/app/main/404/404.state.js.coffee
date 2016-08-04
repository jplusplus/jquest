angular.module 'jquest'
  .config ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.404',
        templateUrl: 'main/404/404.html'
