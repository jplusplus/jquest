angular.module 'jquest'
  .config ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.season.course-materials',
        templateUrl: 'main/season/course-materials/course-materials.html'
        url: 'course-materials'
        controller: 'MainSeasonCourseMaterialsCtrl'
        controllerAs: 'cm'
        resolve:
          $title: -> 'Course Materials'
      .state 'main.season.course-materials.show',
        url: '/:id'
        controller: ($scope, $stateParams, $state, CourseMaterials)->
          'ngInject'
          # Load all materials
          CourseMaterials.load().then ->
            # Select the right one using its id
            CourseMaterials.select $stateParams.id
          $scope.$on 'course-materials:hide', ->
            # Go back to the parent state when closing the panel
            $state.go 'main.season.course-materials'
