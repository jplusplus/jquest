angular.module 'jquest'
  .config ($stateProvider) ->
    $stateProvider
      .state 'main',
        templateUrl: 'main/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
        url: '/'
        data:
          unauthorized: ($state, growl)->
            # Closure function
            ->
              # Redirect to the parent state
              $state.transitionTo '^'
              # And notify the user
              growl.error 'You are not allowed to do this'
        resolve:
          seasons: (Seasons)->
            'ngInject'
            Seasons.ready()
          seasonRestangular: (seasonRestangular)->
            'ngInject'
            seasonRestangular.ready()
