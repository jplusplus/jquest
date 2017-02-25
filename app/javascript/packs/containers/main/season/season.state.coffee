module.exports = ($stateProvider) ->
    'ngInject'
    $stateProvider
      .state 'main.season',
        template: require('./season.html')
        controller: 'MainSeasonCtrl'
        controllerAs: 'season'
        resolve:
          inSeason: (seasons, unauthorized)->
            'ngInject'
            # Gets current user and only bind error callback
            seasons.getCurrent().catch unauthorized
