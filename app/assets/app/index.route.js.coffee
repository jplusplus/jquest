angular.module 'jquest'
  .config ($urlRouterProvider, $locationProvider, cfpLoadingBarProvider) ->
    'ngInject'
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no
    cfpLoadingBarProvider.includeSpinner = no
  .run ($rootScope, $location, $window, $state, $log) ->
    'ngInject'
    $rootScope.$on "$stateChangeError", (event, toState, toParams, fromState, fromParams, error)->
      $log.error toState.name, error
      $state.go 'main.404'
    $rootScope.$on "$stateChangeSuccess", ->
      # Send 'pageview' to Google Analytics
      $window.ga('send', 'pageview', page: $location.url()) if $window.ga?
