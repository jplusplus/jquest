module.exports = ($stateProvider) ->
  'ngInject'
  $stateProvider
    .state 'main.settings',
      template: require('./settings.html')
      controller: 'MainSettingsCtrl'
      controllerAs: 'settings'
      url: 'settings'
      resolve:
        user: (Auth)->
          'ngInject'
          Auth.currentUser()
    .state 'main.settings.account',
      template: require('./account/account.html')
    .state 'main.settings.security',
      template: require('./security/security.html')
