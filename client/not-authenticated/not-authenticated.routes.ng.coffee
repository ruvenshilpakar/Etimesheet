'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'notAuthenticated',
    url: '/not-authenticated/:userId'
    templateUrl: 'client/not-authenticated/not-authenticated.view.html'
    controller: 'NotAuthenticatedCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="normal") 
             return true;
           return 'UNAUTHORIZED'
         )
      ]

  .state 'verify',
    url: '/verify-email/:verifyEmailToken'
    template: 'Verify Email'
    controller:($stateParams, $meteor, $state)->
      Meteor.call('verifyEmail',$stateParams.verifyEmailToken)
      $state.go('notAuthenticated')