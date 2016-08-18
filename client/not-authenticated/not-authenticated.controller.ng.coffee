'use strict'

angular.module 'etimesheetApp'
.controller 'NotAuthenticatedCtrl', ($scope, $stateParams, $meteor) ->
  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {'_id': $stateParams.userId}
  $emailToVerify = $scope.user[0].emails[0].address
  $scope.sendEmail = () ->
    Meteor.call('chkEmailVerify',$stateParams.userId,$emailToVerify)
