'use strict'

angular.module 'etimesheetApp'
.controller 'EmployeesListCtrl', ($scope, $meteor,$mdToast,$mdDialog) ->
  $scope.page = 1
  $scope.perPage = 10
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

  $meteor.session 'usersCounter'
  .bind $scope, 'page'
  
  $scope.showConfirm = (ev,userId) ->
    confirm = $mdDialog.confirm().title('Confirm Delete?').targetEvent(ev).ok('Yes').cancel('Cancel')
    $mdDialog.show(confirm).then (->
      $scope.remove(userId)
      return
    ), ->
      return
    return
  $scope.save = () ->
    if $scope.form.$valid
      $scope.users.save $scope.newEmployee
      $scope.newEmployee = undefined
      $mdToast.show($mdToast.simple().content('Data Saved'))
      
  $scope.remove = (user) ->
    Meteor.call('remove', user)
    $mdToast.show($mdToast.simple().content('User removed'))

  $scope.deactivate = (user) ->
    Meteor.call('deactivate', user)

  $scope.activate = (user) ->
    Meteor.call('activate', user)
    
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
