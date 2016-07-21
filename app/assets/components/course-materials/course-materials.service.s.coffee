angular.module 'jquest'
  .service 'CourseMaterials', ($state, $rootScope, Restangular, localStorageService)->
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
      # Key use to save course-materials selection
      _LS_KEY: 'course-materials:selection'
      constructor: ->
        # Get and save materials
        @load().then @save
        # Watch for state changes to close the panel
        $rootScope.$on "$stateChangeSuccess", @hide
      # Load all
      load: =>
        @_api.getList()
      save: (all)=>
        # Set the scope attribute filtered according the current state
        @_all = all
        @_selected = _.filter @_all, @isSaved
      # Filter course materials according to the current state
      filterCourseMaterials: (courseMaterials)=>
        _.filter courseMaterials, (item)=>
          # Check the state name
          item.state_name is $state.current.name and
          # And check the state params
          @stateContains(item.state_params or {}) and
          # Not already selected!
          not @isSelected item
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
          # Display the panel if the selected item is different or the panel is not visible.
          # We do not get additional resource if the panel is not visible anymore.
          if @toggle( not @isOpen(selected) or not @isVisible() )
            # Mark it as "seen" virtually (not affecting the real data)
            selected.seen = yes
            # Pre-open the course material (with a partial resource)
            @_open = selected
            # Mark it as "seen" on server side
            Restangular.one('course_materials', selected.id).one('seen').put().finally =>
              # Set the "_open" attribute with the right course material from the server
              @_open.get().then (material)=> @_open = material
          # Update saved selection
          do @saveSelection
      unselect: (selected)=>
        # Close the panel if it is open on the selected item
        do @hide if @isOpen selected
        # Find the item
        @removeSelected selected
        # Update saved selection
        do @saveSelection
      getOpen: =>
        @_open
      isOpen: (item)=>
        @isVisible() and @_open?.id is item.id
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
        # Return the state
        @_visible
      show: =>
        @toggle yes
      hide: =>
        @toggle no
      getAll: =>
        @_all
      hasCourseMaterials: =>
        !! @getFiltered().length
      getFiltered: =>
         @filterCourseMaterials @_all
      getSavedSelection: =>
        localStorageService.get @_LS_KEY or []
      saveSelection: =>
        localStorageService.set @_LS_KEY, @getSelectedIds()
      isSaved: (item)=>
        # Item can be an id or an object
        id = if isNaN(item) then item.id else item
        # Look into the saved selection from Locale Storage
        _.includes @getSavedSelection(), id
      getSelected: =>
        @_selected
      getSelectedIds: =>
        _.map @_selected, 'id'
      hasSelected: =>
        !!@_selected.length
      findSelected: (item)=>
        # Item can be an id or an object
        id = parseInt(if isNaN(item) then item.id else item)
        # Find it!
        _.find @_selected, id: id
      isSelected: (item)=>
        !! @findSelected item
      removeSelected: (selected)=>
        # Selected can be an id or an object
        id = if isNaN(selected) then selected.id else selected
        # Find and remove the selected item
        _.remove @_selected, id: id
      addSelected: (selected)=>
        # If we use an ID, we retreive the course
        selected = _.find(@_all, id: parseInt(selected)) unless isNaN selected
        # We add new item
        @_selected.push(selected) unless not selected? or @isSelected(selected)
        # We return the object
        selected

    # Return a single instance of the CourseMaterials
    new CourseMaterials
