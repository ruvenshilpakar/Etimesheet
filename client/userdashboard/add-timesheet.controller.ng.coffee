'use strict'

angular.module 'etimesheetApp'
.controller 'AddTimesheetController', ($scope, $meteor, $stateParams,$rootScope) ->
  $scope.sort = name: parseInt($scope.orderProperty)
  $scope.page = 1
  $scope.perPage = 10
  $scope.projectName=""
  $scope.sort = {name : 1}
  $scope.orderProperty = '1'
  
  $scope.timesheets=[]

  $scope.dailyLogs = $scope.$meteorCollection () ->
    DailyLogs.find {}, {sort:$scope.getReactively('sort')}

  $scope.projects = $scope.$meteorCollection () ->
    Projects.find { $and: [{"deleted":0},{"member":Meteor.userId()}]}, {sort:$scope.getReactively('sort')}
 
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('dailyLogs', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.dailyLogsCount = $scope.$meteorObject Counts, 'numberOfDailyLogs', false
    $scope.$meteorSubscribe('projects')

  $meteor.session 'dailyLogsCounter'
  .bind $scope, 'page'



  $scope.set=(name)->
    $scope.projectName=name

  $scope.addRow=()->
    $scope.timesheets.push({
      projectName:$scope.newDailyLog.name,
      Timetaken:$scope.newDailyLog.Timetaken,
      description:$scope.newDailyLog.Description,
      deleted:0,
      done:false,
      createdBy: $rootScope.currentUser.profile.fName + ' ' +$rootScope.currentUser.profile.lName
      user:$rootScope.currentUser.emails[0].address,
      createdDate:new Date()
      })
    $scope.newDailyLog =""

  $scope.save = () ->
    $scope.newDailyLog=$scope.timesheets
    $scope.dailyLogs.save $scope.newDailyLog
    $scope.newDailyLog = undefined
    $scope.timesheets= undefined
    $scope.timesheets=[]
        
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
