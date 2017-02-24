import 'jquery/dist/jquery.js';
import 'angular';
import 'angular-animate';
import 'angular-cookies';
import 'angular-touch';
import 'angular-sanitize';
import 'angular-messages';
import 'angular-aria';
import 'angular-translate';
import 'angular-translate-loader-static-files';
import 'angular-translate-storage-cookie';
import 'angular-ui-router';
import 'angular-ui-bootstrap';
import 'lodash';
import 'restangular';
import 'angular-devise';
import 'angular-growl-v2';
import 'tether';
import 'angular-hotkeys';
import 'angular-loading-bar';
import 'flatpickr';
import 'ng-infinite-scroll';
import 'angular-local-storage';
import 'd3';
import 'c3';
import 'c3-angular';
import 'angular-ui-router-title';
import 'favico.js';
import 'angular-svg-round-progressbar';
import 'stickyfill';
import 'autolinker';
import 'moment';
import 'angular-moment';
import 'angular-ui-validate';

import {growlConfig, growlRun} from './config/growl.coffee';
import {routesConfig} from './config/routes.coffee';
import {translateConfig, translateRun} from './config/translate.coffee';
import {uiConfig, uiRun} from './config/ui.coffee';

import favico from './components/favico/favico.provider';

angular
  .module('jquest', [
    'ngAnimate',
    'ngCookies',
    'ngTouch',
    'ngSanitize',
    'ngAria',
    'restangular',
    'ui.router',
    'ui.router.title',
    'ui.bootstrap',
    'ui.validate',
    'pascalprecht.translate',
    'angular-growl',
    'angular-loading-bar',
    'Devise',
    'cfp.hotkeys',
    'infinite-scroll',
    'LocalStorageModule',
    'gridshore.c3js.chart',
    'angular-svg-round-progressbar',
    'angularMoment'
  ])
  .provider('favico', favico)
  .config(growlConfig)
  .config(routesConfig)
  .config(translateConfig)
  .config(uiConfig)
  .run(growlRun)
  .run(translateRun)
  .run(uiRun);
