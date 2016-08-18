'use strict'

angular.module 'etimesheetApp'
.controller 'OrganizationDetailCtrl', ($scope, $stateParams,$state, $mdToast,$meteor) ->
  $scope.organization = $scope.$meteorObject Organizations, $stateParams.organizationId
  $scope.$meteorSubscribe('organizations')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.organization.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $state.go('organizations-list')
          mdToast.show($mdToast.simple().content('Organization Updated'))
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.organization.reset()
