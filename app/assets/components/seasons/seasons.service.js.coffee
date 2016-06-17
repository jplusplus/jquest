angular.module 'jquest'
  .service 'Seasons', (Restangular, $window)->
    'ngInject'
    new class Seasons
      _current: {}
      _seasons: []
      constructor: ->
        # Load season to inject into  the menu
        @_promise = do @reload
      # Reload
      reload: =>
        Restangular.all('seasons').getList().then (seasons)=>
          for season in seasons
            if season.engine.root_path is $window.location.pathname
              angular.extend @_current, season
          angular.extend @_seasons, seasons
      all: => @_promise
      ready: =>  @_promise.then => @
      current: => @_current
      hasCurrent: => @_current?
      activities: => @_promise.then => @current().activities
