'use strict'

angular.module 'etimesheetApp'
.controller 'DepartmentsListCtrl', ($scope, $meteor,$mdToast,$mdDialog) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  $scope.toggle= false

  
  $scope.departments = $scope.$meteorCollection () ->
    Departments.find {'deleted':0}, {sort:$scope.getReactively('sort')}
    
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('departments', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.departmentsCount = $scope.$meteorObject Counts, 'numberOfDepartments', false

  $meteor.session 'departmentsCounter'
  .bind $scope, 'page'
  
  $scope.showConfirm = (ev,userId) ->
    confirm = $mdDialog.confirm().title('Confirm Delete?').targetEvent(ev).ok('Yes').cancel('Cancel')
    $mdDialog.show(confirm).then (->
      $scope.remove(userId)
      return
    ), ->
      return
    return  
  
  $scope.toggleForm = ()->
    $scope.toggle= !$scope.toggle

  $scope.cancel = ()->
    $scope.toggle= false
  $scope.save = () ->
    if $scope.departmentForm.$valid
      $scope.newDepartment.deleted=0
      $scope.newDepartment.isActive=1
      $scope.departments.save $scope.newDepartment
      $scope.newDepartment = undefined
      $mdToast.show($mdToast.simple().content('Department Added'))
  
  $scope.remove = (departmentId) ->
    Meteor.call('departmentDelete',departmentId)
    $mdToast.show($mdToast.simple().content('Department Removed'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
