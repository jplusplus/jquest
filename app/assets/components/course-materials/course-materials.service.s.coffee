angular.module 'jquest'
  .service 'CourseMaterials', ($state)->
    'ngInject'
    class CourseMaterials
      constructor: ->
        @_items = []
        @_visible = no
        # Opened course material
        @_opened = null
      # Helper method to show and hide the panel
      select: (item)=>
        # So add it to the list
        @addItem item
        # Set if active
        @_opened = item
        # And display the panel
        do @show
      getOpened: =>
        @_opened
      isVisible: =>
        @_visible
      toggle: =>
        @_visible = not @_visible
      show: =>
        @_visible = yes
      hide: =>
        @_visible = no
      getItems: =>
        @_items
      addItem: (item)=>
        @_items.push(item) unless _.find(@_items, id: item.id)
    # Return a single instance of the CourseMaterials
    new CourseMaterials
