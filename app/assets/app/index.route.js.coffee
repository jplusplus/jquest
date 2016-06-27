angular.module 'jquest'
  .config ($urlRouterProvider, $locationProvider, cfpLoadingBarProvider) ->
    'ngInject'
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no
    cfpLoadingBarProvider.includeSpinner = no
    cfpLoadingBarProvider.latencyThreshold = 0
  .run ($rootScope, $location, $window) ->
    'ngInject'
    $rootScope.$on "$stateChangeSuccess", ->
      # Send 'pageview' to Google Analytics
      $window.ga('send', 'pageview', page: $location.url()) if $window.ga?
