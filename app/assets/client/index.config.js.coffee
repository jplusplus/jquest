angular.module 'jquest'
  .config ($logProvider, RestangularProvider) ->
    # Enable log
    $logProvider.debugEnabled true
    # Set API root
    RestangularProvider.setBaseUrl '/api/v1'
