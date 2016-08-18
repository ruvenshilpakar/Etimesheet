'use strict'

angular.module 'etimesheetApp'
.directive 'toolbar', ['$rootScope', ($rootScope) ->
  restrict: 'EA'
  templateUrl: 'client/components/toolbar/toolbar.view.html'
  replace: true
  link: (scope, elem, attrs) ->
    scope.userType = null
    scope.$watch 'currentUser', (newValue, oldValue) ->
      if newValue
        scope.userType = newValue.profile.role
      else
        # console.log '2'
        scope.userType = false
    # console.log $rootScope.currentUser
    scope.$watch '$root', (newValue, oldValue) ->
      # console.log newValue
      # if newValue
      #   console.log  newValue
      #   # console.log newValue.$root.currentUser
      #   # console.log newValue.$root.currentUser
      #   if newValue
      #     console.log '1'
      #     scope.userType = newValue.profile.role
      #   else
      #     console.log '2'
      #     scope.userType = false

]
