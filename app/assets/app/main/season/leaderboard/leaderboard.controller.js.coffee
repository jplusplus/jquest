angular.module 'jquest'
  .controller 'MainSeasonLeaderboardCtrl', (Auth, points, schools, seasonId)->
    'ngInject'
    new class MainSeasonLeaderboardCtrl
      points: points
      schools: schools
      isSchoolmate: (point)=>
        not @isYou(point) and point.school_id is @user?.school?.id
      isYou: (point)=>
        point.user_id is @user?.id
      schoolIdToName: (id)=>
        @schoolsHash ||= _.keyBy(@schools, 'id');
        # Gets the right school its name
        @schoolsHash[id]?.name
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
          @userSchool = _.find(@schools, id: user.school.id) if user.school?
