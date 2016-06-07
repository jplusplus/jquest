angular.module 'jquest'
  .config (growlProvider)->
    'ngInject'
    growlProvider.globalDisableIcons yes
    growlProvider.globalTimeToLive 5000
    growlProvider.globalDisableCountDown yes
  .run (growl)->
    'ngInject'
    items = document.querySelectorAll '.flash__item'
    for item in items
      element = angular.element(item)
      text =  element.text()
      switch element.attr('data-type').toLowerCase()
        when 'error'   then growl.error text
        when 'success' then growl.success text
        when 'warning' then growl.warning text
        else growl.info element.text()
