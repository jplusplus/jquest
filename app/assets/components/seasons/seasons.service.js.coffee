angular.module 'jquest'
  .service 'Seasons', (Restangular, $window)->
    'ngInject'
    new class Seasons
      _current: null
      constructor: ->
        # Load season to inject into  the menu
        @_seasons = Restangular.all('seasons').getList().then (seasons)=>
          for season in seasons
            if season.engine.root_path is $window.location.pathname
              @_current = season
          seasons
      all: => @_seasons
      ready: =>  @_seasons.then => @
      current: => @_current
      hasCurrent: => @_current?
