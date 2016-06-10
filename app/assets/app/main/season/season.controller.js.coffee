angular.module 'jquest'
  .controller 'MainSeasonCtrl', (seasons)->
    'ngInject'
    new class MainSeasonCtrl
      # Constructor
      constructor: ->
        # User activities for this season
        angular.extend @, seasons.current()
