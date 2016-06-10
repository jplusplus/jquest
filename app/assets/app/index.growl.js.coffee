angular.module 'jquest'
  .config (growlProvider)->
    'ngInject'
    growlProvider.globalDisableIcons yes
    growlProvider.globalTimeToLive 8000
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
        when 'info', 'notice' then growl.info text
        when 'error', 'danger' then growl.error text
        when 'warning', 'alert' then growl.warning text
        else growl.info element.text()
