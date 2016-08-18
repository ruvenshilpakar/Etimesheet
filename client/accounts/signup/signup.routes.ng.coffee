'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'signup',
    url: '/signup'
    templateUrl: 'client/accounts/signup/signup.view.html'
    controller: 'SignupCtrl'
