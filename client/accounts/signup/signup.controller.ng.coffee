'use strict'

angular.module 'etimesheetApp'
.controller 'SignupCtrl', ($scope,$meteor,$stateParams,$state, $mdToast) ->
  $scope.email = ''
  $scope.password=''
  $scope.error=''
  $scope.newEmployee={
    fName:'',
    mName:'',
    lName:'',
    contact:[
      mobileNum:''
      homeNum:''
    ]
    secondaryEmail:''
    address:''
    role:'normal'
    deleted: 0
    isActive: 0
    department:'not assigned'
    designation:'not assigned'
  }
  $scope.passwordConfirm=''

  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {}

  $scope.checkForm= () ->
    if($scope.password!=$scope.passwordConfirm)
      $mdToast.show($mdToast.simple().content('Password Mismatch'))
      return false
    else 
      return true




  $scope.register = () ->
    if($scope.checkForm()==true)
      Accounts.createUser({email:$scope.email,password:$scope.password,profile:$scope.newEmployee},(error) ->
        if(error)
          console.log(error)
        else
          $scope.verification= $scope.user[0].emails[0].verified
          console.log("Verified Token send")
          $scope.emailToVerify = $scope.user[0].emails[0].address
          if($scope.verification==false)
           Meteor.call('chkEmailVerify',Meteor.userId(),$scope.emailToVerify)
           $state.go('notAuthenticated',{userId: Meteor.userId()})
          else
            $state.go('userdashboard')
        )
        

