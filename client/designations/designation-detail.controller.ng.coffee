'use strict'

angular.module 'etimesheetApp'
.controller 'DesignationDetailCtrl', ($scope, $stateParams, $meteor,$state,$mdToast) ->
  $scope.designation = $scope.$meteorObject Designations, $stateParams.designationId
  $scope.$meteorSubscribe('designations')
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.designation.save().then(
        (numberOfDocs) ->
          console.log 'save successful, docs affected ', numberOfDocs
          $state.go('designations-list')
          $mdToast.show($mdToast.simple().content('Designation Updated'))
        (error) ->
          console.log 'save error ', error
      )
        
  $scope.reset = () ->
    $scope.designation.reset()
