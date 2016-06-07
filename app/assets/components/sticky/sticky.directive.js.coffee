angular.module 'jquest'
  .directive 'sticky', ->
    restrict: 'C'
    link: (scope, el)->      
      $(el[0]).fixedsticky()
