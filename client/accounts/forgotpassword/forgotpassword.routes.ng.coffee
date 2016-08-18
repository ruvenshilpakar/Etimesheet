'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'forgotpassword',
    url: '/forgotpassword'
    templateUrl: 'client/accounts/forgotpassword/forgotpassword.view.html'
    controller: 'ForgotPasswordCtrl'
    
