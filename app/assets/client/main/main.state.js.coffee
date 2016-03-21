angular.module 'jquest'
  .config ($stateProvider) ->
    $stateProvider
      .state 'main',
        url: '/'
        templateUrl: 'main/main.html'
        controller: 'MainController'
        controllerAs: 'main'
