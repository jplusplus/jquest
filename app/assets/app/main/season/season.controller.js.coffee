angular.module 'jquest'
  .controller 'MainSeasonCtrl', (activity)->
    'ngInject'
    new class MainSeasonCtrl
      # User activity for this season
      activity: activity
      # Constructor
      constructor: ->
