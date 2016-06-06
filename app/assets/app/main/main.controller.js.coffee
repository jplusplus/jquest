angular.module 'jquest'
  .controller 'MainCtrl', (Auth, $scope)->
    new class MainCtrl
      constructor: ->
        # after a login, a hard refresh, a new tab
        $scope.$on 'devise:login', (event, currentUser)=>
          @currentUser = currentUser
        Auth.currentUser().then (currentUser)->
          # User was logged in, or Devise returned
          # previously authenticated session.
          @currentUser = currentUser
