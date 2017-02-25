module.exports = (user, Restangular, growl, $scope, $state)->
  'ngInject'
  new class MainSettingsCtrl
    save: =>
      @user.save().then (savedUser)=>
          # Update the scope's user
          @user = user = Restangular.copy savedUser
          # Set tehe form as "untouched"
          do $scope.form.$setUntouched
          # Notify user
          growl.success 'Your settings have been saved.'
        # Error...
        , (result)=>
          # Notify user
          growl.error result.data.error or result.statusText
    constructor: ->
      $scope.$on '$stateChangeSuccess', (ev, state)=>
        # Reset the scope user on state change
        @user = Restangular.copy user
        # Alway redirect to a children state
        $state.go 'main.settings.account' if state.name == 'main.settings'
