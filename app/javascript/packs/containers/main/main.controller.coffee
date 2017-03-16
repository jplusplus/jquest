module.exports = (Auth, Menu, seasons, $state, $log, $scope)->
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
    # Constructor
    constructor: ->
      # After a login, a hard refresh, a new tab
      $scope.$on 'devise:login', (event, user)=> @user = user
      # User was logged in, or Devise returned
      # previously authenticated session.
      Auth.currentUser().then (@user)=> null
      # Save all seasons in the scope
      seasons.all().then (@seasons)=> null
      # Print out every states
      # $log.info "Mounted states: ", _.map($state.get(), 'name').join("\n")
