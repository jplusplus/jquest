angular.module 'jquest'
  .controller 'MainCtrl', (Auth, Menu, Restangular, seasons, $state, $log, $scope, $timeout)->
    'ngInject'
    new class MainCtrl
      # State helpers
      state: -> $state.current
      stateParams: -> $state.params
      # Current season must be available
      season: seasons.current()
      # Configurable menu instance
      menu: Menu
      initSlackStatus: =>
        # Get status from the API
        Restangular.one('channels').one('status')
          # Avoid display loading bar for this request
          .withHttpConfig(ignoreLoadingBar: yes).get().then (status)=>
            # Status available within the scope
            @slackStatus = status
        # Trigger a refresh after a short delay
        $timeout @initSlackStatus, 30*1000
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
        # Get channel status from the API
        do @initSlackStatus
