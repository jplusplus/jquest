angular.module 'jquest'
  .controller 'HeaderCtrl', (Menu)->
    new class HeaderCtrl
      constructor: ->
        @_menuVisible = no
      toggleMenu: -> @_menuVisible = !@_menuVisible
      isMenuVisible: -> @_menuVisible
      getMenuItems: Menu.getItems
