angular.module 'jquest'
  .config ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.season',
        templateUrl: 'main/season/season.html'
        controller: 'MainSeasonCtrl'
        controllerAs: 'season'
        url: 'learn'
        resolve:
          activity: (seasons)->
            'ngInject'
            seasons.current().user_activity
