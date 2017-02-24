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

import autolinkFilter from './components/autolink/autolink.filter.coffee';
import courseMaterialsDirective from './components/course-materials/course-materials.directive.coffee';
import courseMaterialsService from './components/course-materials/course-materials.service.coffee';
import favicoProvider from './components/favico/favico.provider';
import fieldsetDirective from './components/fieldset/fieldset.directive.coffee';
import flatpickrDirective from './components/flatpickr/flatpickr.directive.coffee';
import fullscreenDirective from './components/fullscreen-height/fullscreen-height.directive.coffee';
import headerController from './components/header/header.controller.coffee';
import menuService from './components/menu/menu.service.coffee';
import paginatorDirective from './components/paginator/paginator.directive.coffee';
import parallaxDirective from './components/parallax-bg/parallax-bg.directive.coffee';
import seasonRestangularFactory from './components/season-restangular/season-restangular.factory.coffee';
import seasonsService from './components/seasons/seasons.service.coffee';
import stickyDirective from './components/sticky/sticky.directive.coffee';


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
  .provider('favico', favicoProvider)
  .filter('autolink', autolinkFilter)
  .directive('courseMaterials', courseMaterialsDirective)
  .service('CourseMaterials', courseMaterialsService)
  .directive('fieldset', fieldsetDirective)
  .directive('flatpickr', flatpickrDirective)
  .directive('fullscreen', fullscreenDirective)
  .controller('HeaderCtrl', headerController)
  .service('Menu', menuService)
  .directive('paginator', paginatorDirective)
  .directive('parallax', parallaxDirective)
  .factory('seasonRestangular', seasonRestangularFactory)
  .service('Seasons', seasonsService)
  .directive('sticky', stickyDirective)
  .config(growlConfig)
  .config(routesConfig)
  .config(translateConfig)
  .config(uiConfig)
  .run(growlRun)
  .run(translateRun)
  .run(uiRun);
