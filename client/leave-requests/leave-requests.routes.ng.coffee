'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'leaveRequests-list',
    url: '/leave-requests'
    templateUrl: 'client/leave-requests/leave-requests-list.view.html'
    controller: 'LeaveRequestsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )      ]
  .state 'leaveRequest-detail',
    url: '/leave-requests-details'
    templateUrl: 'client/leave-requests/leave-request-detail.view.html'
    controller: 'LeaveRequestDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]
