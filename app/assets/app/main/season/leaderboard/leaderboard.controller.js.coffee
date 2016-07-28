angular.module 'jquest'
  .controller 'MainSeasonLeaderboardCtrl', (Auth, points, schools, seasonId)->
    'ngInject'

    for i in [1..200]
      points.push
        user_id: i*100,
        school_id: 1 + Math.round(Math.random() * 1)
        value: 1 + Math.round(Math.random() * 60)
    points = _.orderBy points, (p)-> -p.value

    new class MainSeasonLeaderboardCtrl
      points: points
      schools: schools
      isSchoolmate: (point)=>
        not @isYou(point) and point.school_id is @user?.school_id
      isYou: (point)=>
        point.user_id is @user?.id
      constructor: ->
        # Extract points sum for this season
        _.map @schools, (s)-> s.points = s.points_sum_by_season[seasonId] or 0
        # Order schools by points
        _.orderBy @schools, (s)-> -s.points
        # Add a position to each school
        _.each @schools, (s1)=>
          # Count the number of school with less points
          s1.position = _.filter(@schools, (s2)-> s2.points > s1.points).length + 1
        # Save the current user
        Auth.currentUser().then (user)=>
          @user = user
          @userSchool = _.find @schools, id: user.school_id
