'use strict'

angular.module 'etimesheetApp'
.controller 'ResetPasswordCtrl', ($scope, $stateParams, $meteor, $state,$mdToast) ->
  $scope.viewName = 'ResetPassword'
  $scope.newPassword = ''
  $scope.error = ''
  $scope.resetPassword= ()->
    if $scope.form.$valid
      # Meteor.call('resetPwd',$stateParams.token,$scope.newPassword)
      Accounts.resetPassword($stateParams.token, $scope.newPassword, (error)->
        if(error)
          console.log(error)
        else
          $mdToast.show($mdToast.simple().content('Password Set Successfully'))
          $state.go('userdashboard')
          
      )
