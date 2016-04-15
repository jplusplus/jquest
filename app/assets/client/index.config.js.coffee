angular.module 'jquest'
  .config ($logProvider, $httpProvider, RestangularProvider, AuthProvider)->
    # Enable log
    $logProvider.debugEnabled yes
    # Set API root
    RestangularProvider.setBaseUrl '/api/v1'
    # See http://www.learnwithdaniel.com/2015/10/rails-angular-authentication/
    # See https://github.com/cloudspace/angular_devise
    $httpProvider.defaults.withCredentials = yes
