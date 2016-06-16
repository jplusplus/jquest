angular.module 'jquest'
  .service 'SeasonRestangular', (Restangular, Seasons)->
    'ngInject'
    # Returns a
    (season=null)->
      # Use Seasons service as fallback
      season = Seasons.current() unless season?
      # Create a Restangular instance
      Restangular.withConfig (RestangularConfigurer)->
        # Dummy API url resolution
        url = season.engine.root_path + 'api/v1/'
        # Set the new base url for this season's API
        RestangularConfigurer.setBaseUrl url
