angular.module 'jquest'
  .controller 'MainCtrl', (Auth, Menu, Restangular, seasons, $state, $log, $scope, $timeout, growl)->
    'ngInject'
    new class MainCtrl
      # State helpers
      state: -> $state.current
      stateParams: -> $state.params
      # Current season must be available
      season: seasons.current()
      inSeason: !angular.equals({}, seasons.current())
      # Configurable menu instance
      menu: Menu
      positionAbbr: (position)=>
        # Position to string
        position = position + ''
        # Choose according the last char
        switch position[ position.length - 1 ]
          when '1' then 'st'
          when '2' then 'nd'
          when '3' then 'rd'
          else 'th'
      requestSlackInvite: =>
        @slackLoading = yes
        # Invite using the API and refresg status
        Restangular.one('channels').one('invite').get().then @initSlackStatus, (res)=>
          # Display error
          growl.error res.error or 'Unbale to get an invite. Try again.'
          # Disable loading state
          @slackLoading = no
      initSlackStatus: =>
        # Trigger a refresh after a short delay
        $timeout @initSlackStatus, 30*1000
        # Get status from the API
        Restangular.one('channels').one('status')
          # Avoid display loading bar for this request
          .withHttpConfig(ignoreLoadingBar: yes).get().then (status)=>
            # Status available within the scope
            @slackStatus = status
      # Constructor
      constructor: ->
        # Print out every states
        $log.info "Mounted states: ", _.map($state.get(), 'name').join("\n")
        # after a login, a hard refresh, a new tab
        $scope.$on 'devise:login', (event, user)=>
          @user = user
        Auth.currentUser().then (user)=>
          # User was logged in, or Devise returned
          # previously authenticated session.
          @user = user
        # Get channel status from the API
        do @initSlackStatus
