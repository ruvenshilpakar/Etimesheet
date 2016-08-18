'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'admin',
    url: '/admin'
    templateUrl: 'client/admin/admin.view.html'
    controller: 'AdminCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]

  .state 'resetPasswordAdmin',
    url: '/reset-password-admin/:token'
    templateUrl: 'client/admin/reset-password-admin.view.html'
    controller: 'ResetPasswordAdminCtrl'
