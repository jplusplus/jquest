angular.module 'jquest'
  .controller 'MainSeasonCourseMaterialsCtrl', (CourseMaterials)->
    'ngInject'
    new class MainSeasonCourseMaterialsCtrl
      # Constructor
      constructor: ->
        CourseMaterials.load().then (all)=>
          # Group materials by category
          @categories = _.groupBy all, 'category'
