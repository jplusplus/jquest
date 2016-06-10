angular.module 'jquest'
  .config (growlProvider)->
    'ngInject'
    growlProvider.globalDisableIcons yes
    growlProvider.globalTimeToLive 8000e3
    growlProvider.globalDisableCountDown yes
    growlProvider.globalPosition 'top-center'
  .run (growl)->
    'ngInject'
    items = document.querySelectorAll '.flash__item'
    for item in items
      element = angular.element(item)
      text =  element.text()
      switch element.attr('data-type').toLowerCase()
        when 'success' then growl.success text
        when 'warning' then growl.warning text
        when 'error', 'danger' then growl.error text
        when 'info', 'notice','alert'  then growl.info text
        else growl.info element.text()
