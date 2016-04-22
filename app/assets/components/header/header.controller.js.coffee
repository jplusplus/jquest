angular.module 'jquest'
  .controller 'HeaderCtrl', (Menu, Restangular, $scope)->
    new class HeaderCtrl
      constructor: ->
        @_menuVisible = no
        # Configurable menu instance
        @menu = Menu
        # Load season to inject into  the menu
        Restangular.all('seasons').getList().then (seasons)=>
          for season in seasons
            @menu.addItem name: season.name, href: season.engine.root_path
        # Watch for state changes
        $scope.$on '$stateChangeStart', => @_menuVisible = no
      toggleMenu: => @_menuVisible = !@_menuVisible
      isMenuVisible: => @_menuVisible
