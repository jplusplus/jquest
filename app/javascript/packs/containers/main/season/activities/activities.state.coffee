module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.season.activities',
      templateUrl: 'main/season/activities/activities.html'
      url: 'activities'
      controller: 'MainSeasonActivitiesCtrl'
      controllerAs: 'activities'
      resolve:
        $title: -> 'Activity Log'
        activities: (Restangular, seasons)->
          Restangular.all('activities').getList(season_id_eq: seasons.current().id)
