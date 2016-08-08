angular.module 'jquest'
  .config ($logProvider, $httpProvider,$uibTooltipProvider, RestangularProvider, AuthProvider, hotkeysProvider, favicoProvider)->
    'ngInject'
    # Are we in production
    if -1 is location.hostname.indexOf 'jquestapp.com'
      # Enable log
      $logProvider.debugEnabled yes
      # Configure a favicon
      favicoProvider.setOptions
        textColor: '#54462b'
        bgColor: '#FFD582'
        type: 'rectangle'
    # Configure tooltips and popover
    $uibTooltipProvider.setTriggers 'outsideClick': 'outsideClick'
    $uibTooltipProvider.options appendToBody: yes
    # Set API root
    RestangularProvider.setBaseUrl '/api/v1'
    RestangularProvider.setRestangularFields selfLink: '@id'
    # Disable hotkey help
    hotkeysProvider.includeCheatSheet = false;
    # See http://www.learnwithdaniel.com/2015/10/rails-angular-authentication/
    # See https://github.com/cloudspace/angular_devise
    $httpProvider.defaults.withCredentials = yes
