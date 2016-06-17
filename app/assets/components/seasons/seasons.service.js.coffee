angular.module 'jquest'
  .service 'Seasons', (Restangular, $window, $rootScope)->
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
          changed = no
          for season in seasons
            if season.engine.root_path is $window.location.pathname
              # Check that the progression have changed
              changed = @_current.progression? and _.some ['level', 'round'], (f)=>
                # Both are still equal
                @_current.progression[f] isnt season.progression[f]
              # Extend the current season value
              angular.extend @_current, season
          # Broadcast an event if the progression (level or round) changed
          $rootScope.$broadcast 'progression:changed', @_current.progression if changed
          # Extend the seasons array
          angular.extend @_seasons, seasons
      all: => @_promise
      ready: =>  @_promise.then => @
      current: => @_current
      hasCurrent: => @_current?
      activities: => @_promise.then => @current().activities
