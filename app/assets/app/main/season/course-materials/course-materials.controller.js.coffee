angular.module 'jquest'
  .controller 'MainSeasonCourseMaterialsCtrl', (CourseMaterials)->
    'ngInject'
    new class MainSeasonCourseMaterialsCtrl
      # Constructor
      constructor: ->
        CourseMaterials.load().then (all)=>
          # Group materials by category
          @categories = _.groupBy all, 'category'
          @categories = _.toPairs @categories
          # Sort categories by take the lower position
          @categories = _.sortBy @categories, (c)=> _.min(c[1], 'position')
