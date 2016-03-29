angular.module 'jquest'
  .service 'Menu', ($state)->
    class MenuItem
      constructor: (attributes={})->
        @name = attributes.name
        @state = attributes.state
      href: (params={})=>
        $state.href @state, params
    class Menu
      constructor: ->
        @_items = []
      getItems: =>
        @_items
      addItem: (item)=>
        @_items.push new MenuItem(item)
    # Return a single instance of the menu
    new Menu
