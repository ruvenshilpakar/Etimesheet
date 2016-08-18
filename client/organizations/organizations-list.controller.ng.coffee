'use strict'

angular.module 'etimesheetApp'
.controller 'OrganizationsListCtrl', ($scope, $meteor,$mdToast,$mdDialog) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  $scope.toggle= false
  
  $scope.organizations = $scope.$meteorCollection () ->
    Organizations.find {'deleted':0}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('organizations', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.organizationsCount = $scope.$meteorObject Counts, 'numberOfOrganizations', false

  $meteor.session 'organizationsCounter'
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
    if $scope.organizationForm.$valid
      $scope.newOrganization.deleted=0
      $scope.newOrganization.isActive=1
      $scope.organizations.save $scope.newOrganization
      $scope.newOrganization = undefined
      $mdToast.show($mdToast.simple().content('Organization Added'))
      
  $scope.remove = (organizationId) ->
    Meteor.call('organizationDelete', organizationId)
    $mdToast.show($mdToast.simple().content('Organization Removed'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
