module.exports =
  template: require('./header.html')
  controllerAs: 'header'
  controller: (Menu, Seasons, $scope, $state, $templateCache, Auth, $timeout, Restangular, growl)->
    'ngInject'
    new class HeaderCtrl
      constructor: ->
        # Add slack templates
        $templateCache.put 'header/slack/slack.html', require('./slack/slack.html')
        # Configurable menu instance
        @menu = Menu
        # Load season to inject into  the menu
        Seasons.all().then (seasons)=>
          for season in seasons
            @menu.addItem name: season.name, href: season.engine.root_path
        # Watch for state changes
        $scope.$on '$stateChangeStart', @menu.hide
        # Get user
        Auth.currentUser().then (user)=>
          # User was logged in, or Devise returned
          # previously authenticated session.
          @user = user
          # Get channel status from the API
          do @initSlackStatus
      requestSlackInvite: =>
        @slackLoadidng = yes
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
