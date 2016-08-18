'use strict'

angular.module 'etimesheetApp'
.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default')
  .primaryPalette('deep-purple')
  .accentPalette('blue-grey')
