angular.module 'jquest'
  .controller 'MainSeasonCtrl', (seasons, $scope, $state, Restangular)->
    'ngInject'
    new class MainSeasonCtrl
      courseMaterials: []
      # Filter course materials according to the current state
      filterCourseMaterials: (courseMaterials)=>
        _.filter courseMaterials, (courseMaterial)=>
          # Check the state name
          courseMaterial.state_name is $state.current.name and
          # And check the state params
          @stateContains(courseMaterial.state_params or {})
      stateContains: (params)->
        for k,value of params
          if not $state.params.hasOwnProperty(k) or $state.params[k] isnt value
            return no
        yes
      # Constructor
      constructor: ->
        # User activities for this season
        angular.extend @, seasons.current()
        # Watch for state changes
        $scope.$on "$stateChangeSuccess", (ev, current)=>
          # Restangular with cache
          api = Restangular.all('course_materials').withHttpConfig cache: yes
          # Get material for this state
          api.getList(state_name: current.name).then (courseMaterials)=>
            # Set the scope attribute filtered according the current state
            @courseMaterials = @filterCourseMaterials courseMaterials
