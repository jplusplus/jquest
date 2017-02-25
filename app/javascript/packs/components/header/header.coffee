module.exports =
  template: require('./header.html.erb')
  controllerAs: 'header'
  bindings:
    user: '<'
  controller: (Menu, Seasons, $scope, $state)->
    'ngInject'
    new class HeaderCtrl
      constructor: ->
        # Configurable menu instance
        @menu = Menu
        # Load season to inject into  the menu
        Seasons.all().then (seasons)=>
          for season in seasons
            @menu.addItem name: season.name, href: season.engine.root_path
        # Watch for state changes
        $scope.$on '$stateChangeStart', Menu.hide
