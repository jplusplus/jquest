angular.module 'jquest'
  .controller 'MainCtrl', (Auth, Menu, seasons, $state, $log, $scope)->
    'ngInject'
    new class MainCtrl
      # State helpers
      state: -> $state.current
      stateParams: -> $state.params
      # Current season must be available
      season: seasons.current()
      # Configurable menu instance
      menu: Menu
      # Constructor
      constructor: ->
        # Print out every states
        $log.info "Mounted states: ", _.map($state.get(), 'name').join("\n")
        # after a login, a hard refresh, a new tab
        $scope.$on 'devise:login', (event, user)=>
          @user = user
        Auth.currentUser().then (user)->
          # User was logged in, or Devise returned
          # previously authenticated session.
          @user = user
