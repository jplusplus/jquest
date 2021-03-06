angular.module 'jquest'
  .service 'Seasons', (Restangular, $window, $rootScope, $q, $translate)->
    'ngInject'
    new class Seasons
      _current: {}
      _seasons: []
      _humanTaxonomies: {}
      constructor: ->
        # Load season to inject into  the menu
        @_promise = do @reload
      # Reload the season and instanciate the current class
      reload: =>
        Restangular.all('seasons').getList().then (seasons)=>
          changed = no
          # Check every seasons
          for season in seasons
            # Valid seasons pathnames
            pathnames = [
              # Check for the season's engine path
              season.engine.root_path,
              # And the same engine path without tailing slash
              season.engine.root_path.slice(0, -1)
            ]
            # Current path mmust match
            if -1 isnt pathnames.indexOf $window.location.pathname
              # Check that the progression have changed
              levelChanged = @_current.progression?.level isnt season.progression.level
              roundChanged = @_current.progression?.round isnt season.progression.round
              # Extend the current season value
              angular.extend @_current, season
          # Broadcast an event if the progression (level or round) changed
          if levelChanged or roundChanged
            # Broadcast an event that received an array describing what changed
            $rootScope.$broadcast 'progression:changed', [levelChanged, roundChanged]
          # Extend the seasons array
          angular.extend @_seasons, seasons
      # Returns the original promise
      all: =>
        @_promise
      # Returns a promise resolved with an array of every season
      ready: =>
        @_promise.then => @
      # True if the user started playing
      alreadyStarted: =>
        # Get season progression details
        { level, round, points } = @current()?.progression
        # Sum progression indicator (level starts at 1, round at 1, points at 0)
        level + round + points > 2
      # Add a human-readable taxonomy for this season's activities
      addHumanTaxonomy: (taxonomy, token)=>
        @_humanTaxonomies[taxonomy] = token
      # Get a human-readable a taxonomy for this season's activities
      getHumanTaxonomy: (activitiy)=>
        $translate.instant @_humanTaxonomies[activitiy.taxonomy] or activitiy.taxonomy, activitiy
      # Get the current season (once @_promise resolved)
      current: =>
        @_current
      # True if the user is exploring a specific season
      hasCurrent: => @_current? and _.keys(@_current).length > 0
      # Promise resolved with the current season
      getCurrent: =>
        # Create and return a promise
        $q (resolve, reject)=>
          # Wait for the service to be ready
          @ready().then =>
            # Resolve with the current season only if we found one!
            if @hasCurrent() then resolve(do @current) else reject()
          # Unable to resolve promise
          , reject
