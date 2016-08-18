'use strict'

angular.module 'etimesheetApp'
.controller 'ForgotPasswordCtrl', ($scope, $meteor, $stateParams, $state, $mdToast) ->
  $scope.credentials = 
    email: ''

  $scope.error = ''

  

  $scope.forgotPwd = ()->
    if ($scope.credentials.email !='')
      Accounts.forgotPassword({email:$scope.credentials.email}, (error)->
        if(error)
          $scope.error = 'Error Sending forgot password email - ' + err
        else
          $state.go 'login'
          $mdToast.show($mdToast.simple().content('Check Email for reset'))
        )
        
    else
      $scope.error = 'Enter your email address'

