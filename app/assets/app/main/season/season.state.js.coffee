angular.module 'jquest'
  .config ($stateProvider) ->
    $stateProvider
      .state 'main.season',
        url: 'season'
        template: '{{ "yolo" | translate }}'
