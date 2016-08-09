angular.module 'jquest'
  .controller 'MainSeasonActivitiesCtrl', (seasons, Paginator, activities)->
    'ngInject'
    new class MainSeasonActivitiesCtrl
      all: new Paginator(activities)
      toHuman: seasons.getHumanTaxonomy
