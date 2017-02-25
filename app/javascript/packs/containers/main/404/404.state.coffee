module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.404',
      templateUrl: 'main/404/404.html'
    .state 'main.404.page',
      templateUrl: 'main/404/404.html'
      url: '404'
