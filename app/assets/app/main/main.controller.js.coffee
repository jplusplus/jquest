angular.module 'jquest'
  .controller 'MainCtrl', (Auth, Menu, seasons, $scope)->
    'ngInject'
    new class MainCtrl
      # Current season must be available
      season: seasons.current()
      # Configurable menu instance
      menu: Menu
      # Constructor
      constructor: ->
        # after a login, a hard refresh, a new tab
        $scope.$on 'devise:login', (event, user)=>
          @user = user
        Auth.currentUser().then (user)->
          # User was logged in, or Devise returned
          # previously authenticated session.
          @user = user
