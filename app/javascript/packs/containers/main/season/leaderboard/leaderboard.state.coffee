module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.season.leaderboard',
      templateUrl: 'main/season/leaderboard/leaderboard.html'
      url: 'leaderboard'
      controller: 'MainSeasonLeaderboardCtrl'
      controllerAs: 'leaderboard'
      resolve:
        $title: -> 'Leaderboard'
        seasonId: (seasons)->
          'ngInject'
          # Get current season id
          seasons.current().id
        schools: (Restangular, seasonId)->
          'ngInject'
          # Get all schools for this season
          Restangular.all('schools').getList(limit: 1e4).then (schools)->
            # Only schools with points
            _.filter schools, (s)-> s.points_sum_by_season[seasonId] > 0
        points: (Restangular, seasonId)->
          'ngInject'
          # Get all point for this season
          Restangular.all('points').getList limit: 1e4, season_id_eq: seasonId
