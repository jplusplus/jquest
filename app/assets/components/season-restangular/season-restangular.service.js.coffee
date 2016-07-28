angular.module 'jquest'
  .factory 'seasonRestangular', (Restangular, Seasons, $q)->
    'ngInject'
    # Create a deferred result
    ready: ->
      $q (resolve)->
        # Resolve season first
        Seasons.ready().then ->
          # Use Seasons service as fallback
          season = Seasons.current()
          # Create a Restangular instance
          service = Restangular.withConfig (RestangularConfigurer)->
            # Avoid creating a service when there is no "current season"
            if season?.engine?
              # Dummy API url resolution
              url = season.engine.root_path + 'api/v1/'
              # Set the new base url for this season's API
              RestangularConfigurer.setBaseUrl url
          # Resolve the promise
          resolve service
