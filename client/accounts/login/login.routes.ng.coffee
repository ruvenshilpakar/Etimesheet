'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'client/accounts/login/login.view.html'
    controller: 'LoginCtrl'
    resolve: 'currentUser': [
      '$meteor',
      ($meteor) ->
        return $meteor.waitForUser()
    ]
  .state 'logout',
    url: '/logout'
    resolve:
      "logout": ['$meteor', '$state', ($meteor, $state) -> 
        return $meteor.logout().then( -> 
          $state.go('login');
        , (err) -> 
          console.log('logout error - ', err);
        )
      ]
