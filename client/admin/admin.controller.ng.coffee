'use strict'

angular.module 'etimesheetApp'
.controller 'AdminCtrl', ($scope, $meteor) ->
  $scope.viewName = 'Admin'
  $scope.isAdmin = false

  # $scope.user = $scope.$meteorCollection () ->
  #   Meteor.users.find {}

  # $meteor.autorun $scope, () ->
  #   # console.log($scope.user)
    # $scope.loginRole=$scope.user[0].profile.role 
    # if($scope.loginRole=='admin')
    #   $scope.isAdmin= true


