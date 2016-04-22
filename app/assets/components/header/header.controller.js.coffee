angular.module 'jquest'
  .controller 'HeaderCtrl', (Menu, Seasons, $scope)->
    new class HeaderCtrl
      constructor: ->
        # Configurable menu instance
        @menu = Menu
        # Load season to inject into  the menu
        Seasons.all().then (seasons)=>
          for season in seasons
            @menu.addItem name: season.name, href: season.engine.root_path
          # The current page is a season
          if Seasons.hasCurrent()
            unless Menu.hasPrimaryColor()
              Menu.setPrimaryColor Seasons.current().primary_color
            unless Menu.hasTitle()
              Menu.setTitle Seasons.current().name
        # Watch for state changes
        $scope.$on '$stateChangeStart', Menu.hide
