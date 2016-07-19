angular.module 'jquest'
  .service 'CourseMaterials', ($state, $rootScope, Restangular)->
    'ngInject'
    class CourseMaterials
      constructor: ->
        @_selected = []
        @_all = []
        @_visible = no
        # Open course material
        @_open = null
        # Restangular API endpoint
        @_api = Restangular.all('course_materials')
        # Watch for state changes
        $rootScope.$on "$stateChangeSuccess", =>
          # Close the panel
          do @hide
          # Get material for this state
          @_api.withHttpConfig(cache: yes).getList().then (courseMaterials)=>
            # Set the scope attribute filtered according the current state
            @_all = @filterCourseMaterials courseMaterials
      # Filter course materials according to the current state
      filterCourseMaterials: (courseMaterials)=>
        _.filter courseMaterials, (courseMaterial)=>
          # Check the state name
          courseMaterial.state_name is $state.current.name and
          # And check the state params
          @stateContains(courseMaterial.state_params or {})
      # True if the current state contains the given params
      stateContains: (params)->
        for k,value of params
          if not $state.params.hasOwnProperty(k) or $state.params[k] isnt value
            return no
        yes
      # Helper method to show and hide the panel
      select: (selected)=>
        # So add it to the list
        @addSelected selected
        # Display the panel if the selected item is different or the panel is not visible
        @toggle not @isOpen(selected) or not @isVisible()
        # Set if active
        @_open = Restangular.one('course_materials', selected.id).withHttpConfig(cache: yes).get().$object
      getOpen: =>
        @_open
      isOpen: (item)=>
        @_open?.id is item.id
      isVisible: =>
        @_visible
      toggle: (visible)=>
        @_visible = if visible? then visible else not @_visible
      show: =>
        @_visible = yes
      hide: =>
        @_visible = no
      getAll: =>
        @_all
      hasCourseMaterials: =>
        !!@_all.length
      getSelected: =>
        @_selected
      hasSelected: =>
        !!@_selected.length
      addSelected: (selected)=>
        @_selected.push(selected) unless _.find(@_selected, id: selected.id)
    # Return a single instance of the CourseMaterials
    new CourseMaterials
