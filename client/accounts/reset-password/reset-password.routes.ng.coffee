'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'resetPassword',
    url: '/reset-password/:token'
    templateUrl: 'client/accounts/reset-password/reset-password.view.html'
    controller: 'ResetPasswordCtrl'
