'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'employees-list',
    url: '/employees'
    templateUrl: 'client/employees/employees-list.view.html'
    controller: 'EmployeesListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]
  .state 'employee-detail',
    url: '/employees/:userId'
    templateUrl: 'client/employees/employee-detail.view.html'
    controller: 'EmployeeDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]
