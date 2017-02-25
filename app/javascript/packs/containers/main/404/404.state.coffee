module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.404',
      template: require('./404.html')
    .state 'main.404.page',
      template: require('./404.html')
      url: '404'
