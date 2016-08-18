'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectDetailCtrl', ($scope, $meteor, $state, $stateParams,$mdToast) ->
  
  $scope.idx=0
 

  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {"deleted":0}, {sort:$scope.getReactively('sort')}

  $scope.project = $scope.$meteorObject Projects, $stateParams.projectId
  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {"profile.deleted":0}, {sort:$scope.getReactively('sort')}
  
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('projects', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.projectsCount = $scope.$meteorObject Counts, 'numberOfProjects', false
    $meteor.subscribe('users')
    
  $scope.member=$scope.project.member

  $meteor.session 'projectsCounter'
  .bind $scope, 'page'

  $scope.shouldBeDisabled= (users)->
    if(users== '1')
      return true
    else
      return false
  
  $scope.exists=(users,list)->
    return list.indexOf(users) > -1

  $scope.toggle =  (users, list)->
    $scope.idx = list.indexOf(users)
    if($scope.idx > -1)
     list.splice($scope.idx, 1)
    else
     list.push(users)
    
  $scope.save = () ->
    $scope.project.deleted=0
    $scope.project.isActive=1
    $scope.project.member=$scope.member
    $scope.projects.save $scope.project
    $scope.project = undefined 
    document.getElementById("form").reset()
    $scope.member=[]
    $scope.idx=0 
    $state.go('projects-list')
    $mdToast.show($mdToast.simple().content('Project Saved Sucessfully'))
  

  $scope.remove = (projectId) ->
    Meteor.call('projectDelete', projectId)
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)

  $scope.update=(project)->
    $scope.projects.update project    

  $scope.reset = () ->
    $scope.project.reset()
