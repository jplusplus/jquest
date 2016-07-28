angular.module 'jquest'
  .config ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.season.leaderboard',
        templateUrl: 'main/season/leaderboard/leaderboard.html'
        url: 'leaderboard'
        controller: 'MainSeasonLeaderboardCtrl'
        controllerAs: 'leaderboard'
