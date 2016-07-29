angular.module 'jquest'
  .config ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.season',
        templateUrl: 'main/season/season.html'
        controller: 'MainSeasonCtrl'
        controllerAs: 'season'
        resolve:
          unauthorized: ($state)->
            'ngInject'
            # Closure function that redirect to the 403 state
            ->
              # Redirect to error 403 page
              $state.go 'main.403'
          inSeason: (seasons, unauthorized)->
            'ngInject'
            # Must have a season or redirect to '403 state
            seasons.getCurrent().then angular.noop, unauthorized
          authenticate: (Auth, unauthorized)->
            'ngInject'
            # Gets current user and only bind error callback
            Auth.currentUser().then angular.noop, unauthorized
