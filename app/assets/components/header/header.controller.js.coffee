angular.module 'jquest'
  .controller 'HeaderCtrl', ->
    new class HeaderCtrl
      constructor: ->
        @_menuVisible = no
      toggleMenu: -> @_menuVisible = !@_menuVisible
      isMenuVisible: -> @_menuVisible
