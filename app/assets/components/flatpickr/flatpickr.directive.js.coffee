angular.module 'jquest'
  .directive 'flatpickr', ->
    restrict: 'AC'
    require: 'ngModel',
    link: (scope, element, attrs, ngModel)->
      fp = new Flatpickr element[0]
      # Helper to sync the flatpickr with modelValue
      syncModelValue = ->
        if ngModel.$modelValue?
          # We change the calendar date
          fp.setDate new Date(ngModel.$modelValue)
      # Sync the modelValue with flatpickr
      element.on 'click', ->
        scope.$apply ->
          ngModel.$setViewValue fp.selectedDateObj
      # We leave the input
      element.on 'blur', syncModelValue
      # Watch for key press
      element.on "keydown keypress", (event)->
        # Sync view value if the pressed key is enter
        do syncModelValue if event.which is 13
      # Validate the model value
      ngModel.$validators.validDate = (modelValue, viewValue)->
        # We must be able to parse the date
        ngModel.$isEmpty(modelValue) or not isNaN Date.parse modelValue
