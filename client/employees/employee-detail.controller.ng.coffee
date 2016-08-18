'use strict'

angular.module 'etimesheetApp'
.controller 'EmployeeDetailCtrl', ($scope, $stateParams, $state, $meteor, $mdToast) ->
  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {'_id':$stateParams.userId}

  

  $scope.departments = $scope.$meteorCollection () ->
    Departments.find {'deleted':0}, {sort:$scope.getReactively('sort')}

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('departments', {
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      limit: parseInt($scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.departmentsCount = $scope.$meteorObject Counts, 'numberOfDepartments', false

  $scope.designations = $scope.$meteorCollection () ->
    Designations.find {'deleted':0}, {sort:$scope.getReactively('sort')}
  
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('designations', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.designationsCount = $scope.$meteorObject Counts, 'numberOfDesignations', false  
  

  
  $scope.email=$scope.users[0].emails[0].address
  $scope.address=$scope.users[0].profile.address
  $scope.fName=$scope.users[0].profile.fName
  $scope.mName=$scope.users[0].profile.mName
  $scope.lName=$scope.users[0].profile.lName
  $scope.mobileNum=$scope.users[0].profile.contact[0].mobileNum
  $scope.homeNum=$scope.users[0].profile.contact[0].homeNum
  $scope.secondaryEmail=$scope.users[0].profile.contact.secondaryEmail
  $scope.department=$scope.users[0].profile.department
  $scope.designation=$scope.users[0].profile.designation


  
  $scope.save = () ->
   Meteor.call('update', $stateParams.userId,  $scope.fName, $scope.mName, $scope.lName, $scope.mobileNum, $scope.homeNum, $scope.address ,$scope.department, $scope.designation)
   $mdToast.show($mdToast.simple().content('Datas Saved'));
   $state.go 'employees-list'
        
  $scope.reset = () ->
    $scope.employee.reset()
