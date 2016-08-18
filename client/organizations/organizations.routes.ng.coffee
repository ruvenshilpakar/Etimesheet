'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'organizations-list',
    url: '/organizations'
    templateUrl: 'client/organizations/organizations-list.view.html'
    controller: 'OrganizationsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]
  .state 'organization-detail',
    url: '/organizations/:organizationId'
    templateUrl: 'client/organizations/organization-detail.view.html'
    controller: 'OrganizationDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.profile.role=="admin") 
             return true;
           return 'FORBIDDEN'
         )
      ]
