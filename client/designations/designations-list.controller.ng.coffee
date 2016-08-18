'use strict'

angular.module 'etimesheetApp'
.controller 'DesignationsListCtrl', ($scope, $meteor,$mdToast,$mdDialog) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  $scope.toggle= false
  
  $scope.designations = $scope.$meteorCollection () ->
    Designations.find {'deleted':0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('designations', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.designationsCount = $scope.$meteorObject Counts, 'numberOfDesignations', false

  $meteor.session 'designationsCounter'
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
    if $scope.designationForm.$valid
      $scope.newDesignation.deleted=0
      $scope.newDesignation.isActive=1
      $scope.designations.save $scope.newDesignation
      $scope.newDesignation = undefined
      $mdToast.show($mdToast.simple().content('Designation Added'))
      
  $scope.remove = (designationId) ->
    Meteor.call('updateDesignation',designationId)
    $mdToast.show($mdToast.simple().content('Designation Removed'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
