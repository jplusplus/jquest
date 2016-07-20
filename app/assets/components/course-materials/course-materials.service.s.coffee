angular.module 'jquest'
  .service 'CourseMaterials', ($state, $rootScope, Restangular)->
    'ngInject'
    class CourseMaterials
      ### Pirvate attributes
      ###
      _selected: []
      _all: []
      _visible: no
      # Open course material
      _open: null
      # Restangular API endpoint
      _api: Restangular.all 'course_materials'
      constructor: ->
        # Get materials
        @load().then (courseMaterials)=>
          # Set the scope attribute filtered according the current state
          @_all = courseMaterials
        # Watch for state changes
        $rootScope.$on "$stateChangeSuccess", =>
          # Close the panel
          do @hide
      # Load all
      load: => @_api.getList()
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
        if selected = @addSelected selected
          # Display the panel if the selected item is different or the panel is not visible
          @toggle not @isOpen(selected) or not @isVisible()
          # Do not any additional resource if the panel is not visible anymore
          if @isVisible()
            # Mark it as "seen" virtually (not affecting the real data)
            selected.seen = yes
            # Mark it as "seen" on server side
            Restangular.one('course_materials', selected.id).one('seen').put().finally =>
              # Set the "_open" attribute with the right course material from the server
              @_open = Restangular.one('course_materials', selected.id).get().$object
      unselect: (selected)=>
        # Close the panel if it is open on the selected item
        do @hide if @isOpen selected
        # Find the item
        _.remove @_selected, id: selected.id
      getOpen: =>
        @_open
      isOpen: (item)=>
        @_open?.id is item.id
      isVisible: =>
        @_visible
      isSeen: (item)=>
        item.seen or _.find(@_all, id: item.id)?.seen
      toggle: (visible)=>
        # Save the previous state
        previous = @_visible
        # Do we receive a value? If not, we take the opposite of the current one
        @_visible = if visible? then visible else not @_visible
        # The visibility changed
        if previous isnt @_visible
          # Broadcast an event
          $rootScope.$broadcast 'course-materials:' + (if @_visible then 'show' else 'hide')
      show: =>
        @toggle yes
      hide: =>
        @toggle no
      getAll: =>
        @_all
      hasCourseMaterials: =>
        !!@_all.length
      getFiltered: =>
         @filterCourseMaterials @_all
      getSelected: =>
        @_selected
      hasSelected: =>
        !!@_selected.length
      addSelected: (selected)=>
        # If we use an ID, we retreive the course
        selected = _.find(@_all, id: parseInt(selected)) unless isNaN selected
        # We add new item
        @_selected.push(selected) unless not selected? or _.find(@_selected, id: selected.id)
        # We return the object
        selected

    # Return a single instance of the CourseMaterials
    new CourseMaterials
