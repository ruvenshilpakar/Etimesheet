'use strict'

angular.module 'etimesheetApp'
.controller 'ResetPasswordAdminCtrl', ($scope, $stateParams, $meteor, $state,$mdToast) ->
  $scope.newPassword = ''
  $scope.error = ''
  $scope.resetPassword= ()->
    if $scope.form.$valid
      # Meteor.call('resetPwd',$stateParams.token,$scope.newPassword)
      Meteor.call('resetPasswordAdmin',$stateParams.token, $scope.newPassword)
      $state.go('employees-list')
