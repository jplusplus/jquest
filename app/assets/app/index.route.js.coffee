angular.module 'jquest'
  .config ($urlRouterProvider, $locationProvider, cfpLoadingBarProvider) ->
    'ngInject'
    $urlRouterProvider.otherwise '/'
    $locationProvider.hashPrefix '!'
    $locationProvider.html5Mode no
    cfpLoadingBarProvider.includeSpinner = no
  .run ($rootScope, $location, $window, $state) ->
    'ngInject'
    $rootScope.$on "$stateChangeError", ->
      $state.go 'main.403'
    $rootScope.$on "$stateChangeSuccess", ->
      # Send 'pageview' to Google Analytics
      $window.ga('send', 'pageview', page: $location.url()) if $window.ga?
