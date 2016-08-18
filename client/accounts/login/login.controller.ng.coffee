'use strict'

angular.module 'etimesheetApp'
.controller 'LoginCtrl',['$scope', '$meteor','$stateParams', '$state', ($scope, $meteor, $stateParams, $state) ->
  $scope.credentials =
    email: ''
    password: ''
  $scope.error = ''
  

  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {}



  $scope.loginOauth = (media) ->
    switch (media)
      when 'facebook'
        console.log('in')
        Meteor.loginWithFacebook {requestPermissions: ['email']}, (err) ->
          $scope.error = 'facebook Login error - ' + err
          console.log('in method', err)
      when 'google'
        Meteor.loginWithGoogle {requestPermissions: ['email', 'profile']}, (err) ->
          $scope.error = 'Google Login error - ' + err
      when 'twitter'
        Meteor.loginWithTwitter {requestPermissions: ['email', 'profile']}, (err) ->
          $scope.error = 'Twitter Login error - ' + err

  $scope.toggleToolbar =()->
    if(($scope.userLogged==true)&&($scope.isEmployee==true))
      $scope.employeeToolbar = true


  $scope.login =() ->
    $meteor.loginWithPassword($scope.credentials.email, $scope.credentials.password).then (->
      # console.log('clicked')
      $scope.loginRole=$scope.user[0].profile.role 
      $scope.emailToVerify = $scope.user[0].emails[0].address
      # console.log($scope.user[0].emails[0].address)
      # console.log($scope.user[0].emails[0].verified)
      $scope.userLogged=true

      if($scope.loginRole=='admin')
        $state.go 'admin'
      else
        # $scope.toggleToolbar()
        $scope.verificationState = $scope.user[0].emails[0].verified
        if($scope.currentUser.profile.deleted==1)
          $state.go('logout')
          $scope.error = 'Login error - user not found '
        else if($scope.verificationState==false || $scope.currentUser.profile.isActive==0)
          $state.go('notAuthenticated',{userId: Meteor.userId()})
          Meteor.call('chkEmailVerify',Meteor.userId(),$scope.emailToVerify)
        else
          $state.go 'userdashboard'
    ), (err) ->
      $scope.error = 'Login error - ' + err
]


