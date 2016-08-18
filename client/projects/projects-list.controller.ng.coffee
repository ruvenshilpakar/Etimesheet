'use strict'

angular.module 'etimesheetApp'
.controller 'ProjectsListCtrl', ($scope, $meteor,$mdToast,$mdDialog) ->
  $scope.member=[]
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  $scope.switch= false
  
  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {"deleted":0}, {sort:$scope.getReactively('sort')}

  $scope.users = $scope.$meteorCollection () ->
    Meteor.users.find {"profile.deleted":0}, {sort:$scope.getReactively('sort')}

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('users')

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('projects', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.projectsCount = $scope.$meteorObject Counts, 'numberOfProjects', false

  $meteor.session 'projectsCounter'
  .bind $scope, 'page'
  
  $scope.toggleForm = ()->
    $scope.switch= !$scope.switch

  $scope.cancel = ()->
    $scope.switch= false

  $scope.showConfirm = (ev,userId) ->
    confirm = $mdDialog.confirm().title('Confirm Delete?').targetEvent(ev).ok('Yes').cancel('Cancel')
    $mdDialog.show(confirm).then (->
      $scope.remove(userId)
      return
    ), ->
      return
    return  
  
  $scope.shouldBeDisabled= (users)->
    if(users== '1')
      return true
    else
      return false
  
  $scope.exist=(users,list)->
    return list.indexOf(users) > -1

  $scope.toggle =  (users, list)->
    $scope.idx = list.indexOf(users)
    if($scope.idx > -1)
     list.splice($scope.idx, 1)
    else
     list.push(users)
  
  $scope.save = () ->
    if $scope.form.$valid
      $scope.newProject.deleted=0
      $scope.newProject.isActive=1
      $scope.newProject.member=$scope.member
      $scope.projects.save $scope.newProject
      $scope.newProject = undefined
      document.getElementById("projectForm").reset()
      $scope.member=[]
      $scope.idx=0 
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
