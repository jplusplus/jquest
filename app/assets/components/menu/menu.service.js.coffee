angular.module 'jquest'
  .service 'Menu', ($state)->
    'ngInject'
    class MenuItem
      constructor: (attributes={})->
        @name     = attributes.name
        @state    = attributes.state or null
        @href     = attributes.href
        @category = attributes.category or null
        @priority = attributes.priority or 0
      getHref: (params={})=>
        href  = @href or ''
        href += $state.href(@state, params) or ''
      isActive: =>
        $state.current.name is @state if @state?
    class Menu
      constructor: ->
        @_items = []
        @_visible = no
      isVisible: =>
        @_visible
      toggle: =>
        @_visible = not @_visible
      show: =>
        @_visible = yes
      hide: =>
        @_visible = no
      hasTitle: =>
        @_title?
      getTitle: =>
        @_title
      setTitle: (title)=>
        @_title = title
      hasPrimaryColor: =>
        @_primaryColor?
      getPrimaryColor: =>
        @_primaryColor
      setPrimaryColor: (primaryColor)=>
        @_primaryColor = primaryColor
      getCategories: (category)=>
        # Inspect items to findd categories
        categories = _.chain(@_items).map('category').uniq().sort().value()
        # Move empty category to the top
        categories.unshift(categories.pop())
        categories
      getItems: (category=null)=>
        _.chain(@_items).filter(category: category).sortBy('priority').reverse().value()
      addItem: (item)=>
        @_items.push new MenuItem(item) unless _.find @_items, name: item.name
    # Return a single instance of the menu
    new Menu
