module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.403',
      template: require('./403.html')
