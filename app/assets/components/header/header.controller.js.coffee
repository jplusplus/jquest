angular.module 'jquest'
  .controller 'HeaderCtrl', (Menu, Restangular)->
    new class HeaderCtrl
      constructor: ->
        @_menuVisible = no
        @_seasons = Restangular.all('seasons').getList().$object
      toggleMenu: -> @_menuVisible = !@_menuVisible
      isMenuVisible: -> @_menuVisible
      getSeasons: => @_seasons
      getMenuItems: Menu.getItems
