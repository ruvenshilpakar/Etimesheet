'use strict'

angular.module 'etimesheetApp'
.controller 'AddLeaveRequestController', ($scope, $meteor,$mdToast) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  $scope.dataOwner=Meteor.userId()
  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {"deleted":0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('leaveRequests', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    },{ownerId:$scope.dataOwner}, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
    
  $scope.save = () ->
    if $scope.form.$valid
      $scope.newLeaveRequest.ownerId = Meteor.userId()
      $scope.newLeaveRequest.askedDate = new Date()
      $scope.newLeaveRequest.status = 'Pending'
      $scope.newLeaveRequest.deleted = 0
      $scope.newLeaveRequest.requestedBy = $scope.currentUser.profile.fName + ' ' + $scope.currentUser.profile.lName
      $scope.leaveRequests.save $scope.newLeaveRequest
      $scope.newLeaveRequest = undefined
      
  $scope.remove = (leaveRequestid) ->
    Meteor.call('cancelLeaveRequest', leaveRequestid)
    $mdToast.show($mdToast.simple().content('Deleted'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)

