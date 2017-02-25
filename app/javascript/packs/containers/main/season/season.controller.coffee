module.exports = (seasons, $scope, $timeout, $state, Restangular)->
  'ngInject'
  new class MainSeasonCtrl
    pointsChanged: no
    seeksAttentionOnPoint: => @pointsChanged
    checkPoints: (points, old)=>
      # Set the toggle attribute to true when points changes
      @pointsChanged = old? and points isnt old
      # Reset the toggle attribute after a short delay
      $timeout (=> @pointsChanged = no ), 1000
    # Constructor
    constructor: ->
      # User activities for this season
      angular.extend @, seasons.current()
      # Watch for change on points
      $scope.$watch (-> seasons.current().progression.points ), @checkPoints
