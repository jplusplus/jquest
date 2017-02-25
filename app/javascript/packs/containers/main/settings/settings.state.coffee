module.exports = ($stateProvider) ->
  $stateProvider
    .state 'main.settings',
      templateUrl: 'main/settings/settings.html'
      controller: 'MainSettingsCtrl'
      controllerAs: 'settings'
      url: 'settings'
      resolve:
        user: (Auth)->
          'ngInject'
          Auth.currentUser()
    .state 'main.settings.account',
      templateUrl: 'main/settings/account/account.html'
    .state 'main.settings.security',
      templateUrl: 'main/settings/security/security.html'
