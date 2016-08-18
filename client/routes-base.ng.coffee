'use strict'

angular.module 'etimesheetApp'

.config ($urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $urlRouterProvider.otherwise '/login'

.run ($rootScope, $state) ->
  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    switch error
      when 'AUTH_REQUIRED'
        $state.go 'login'
      when 'FORBIDDEN', 'NOTVERIFED'
        $state.go 'userdashboard'
      when 'UNAUTHORIZED'
        $state.go 'admin'
