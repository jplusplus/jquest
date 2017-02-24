angular.module 'jquest'
  .controller 'MainSeasonCourseMaterialsCtrl', (CourseMaterials, $scope)->
    'ngInject'
    new class MainSeasonCourseMaterialsCtrl
      search: null
      all: null
      # Constructor
      constructor: ->
        CourseMaterials.load().then (all)=>
          # Save all course
          @all = all
          # Prepare a filtered subset
          do @filterCourseMaterials
          # Watch for change on the search attribute
          $scope.$watch 'cm.search', @filterCourseMaterials
      # Filter all course materials (if needed) and create categories
      filterCourseMaterials: =>
        if @search?
          # Filter according to a search token
          filtered = _.filter @all, (c)=>
            # Search the token with normalized chars in the title
            c.title.toLowerCase().indexOf(@search.toLowerCase()) isnt -1 or
            # Search also in the category name
            c.category.toLowerCase().indexOf(@search.toLowerCase()) isnt -1
        else
          filtered = @all
        # Group materials by category
        @categories = _.groupBy filtered, 'category'
        @categories = _.toPairs @categories
        # Sort categories by take the lower position
        @categories = _.sortBy @categories, (c)=> _.min(c[1], 'position')
