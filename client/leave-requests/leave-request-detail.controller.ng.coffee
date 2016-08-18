'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestDetailCtrl', ($scope, $stateParams, $meteor) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  

  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {"profile.deleted":0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('users', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.usersCount = $scope.$meteorObject Counts, 'numberOfUsers', false

  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {"deleted": 0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('allLeaveRequestsAdmin', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('userFilter'),$scope.getReactively('statusFilter')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfAllLeaveRequests', false,

  $scope.resetFilter=()->
    $scope.userFilter= ''
    $scope.statusFilter= ''

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
    
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
  
  
