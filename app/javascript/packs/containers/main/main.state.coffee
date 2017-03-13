module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider.state 'main',
    template: require('./main.html')
    controller: 'MainCtrl'
    controllerAs: 'main'
    url: '/'
    resolve:
      unauthorized: ($state)->
        'ngInject'
        # Closure function that redirect to the 403 state
        ->
          # Redirect to error 403 page
          $state.go 'main.403'
      seasons: (Seasons)->
        'ngInject'
        Seasons.ready()
      seasonRestangular: (seasonRestangular)->
        'ngInject'
        seasonRestangular.ready()
