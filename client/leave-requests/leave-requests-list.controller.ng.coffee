'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestsListCtrl', ($scope, $meteor) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {"deleted": 0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('leaveRequestsAdmin', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
    

  $scope.approve = (leaveRequestid) ->
    Meteor.call('approveLeave', leaveRequestid)
    console.log('clicked')

  $scope.discard = (leaveRequestid) ->
    Meteor.call('discardLeave', leaveRequestid)  

    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
