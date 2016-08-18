'use strict'

angular.module 'etimesheetApp'
.controller 'DailyLogsListCtrl', ($scope, $meteor,$mdDialog,$mdToast) ->
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = {name : 1}
  $scope.orderProperty = '1'



  $scope.dailyLogs = $scope.$meteorCollection () ->
    DailyLogs.find {deleted:0}, {sort:$scope.getReactively('sort')}

  $scope.projects = $scope.$meteorCollection () ->
    Projects.find {}, {sort:$scope.getReactively('sort')}

  $scope.users = $scope.$meteorCollection ()->
    Meteor.users.find {"profile.deleted":0}, {sort:$scope.getReactively('sort')}

  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('dailyLogs', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('userFilter'),$scope.getReactively('projectFilter')).then () ->
      $scope.dailyLogsCount = $scope.$meteorObject Counts, 'numberOfDailyLogs', false
    
    $scope.$meteorSubscribe('projects')
    $scope.$meteorSubscribe('users')

  $meteor.session 'dailyLogsCounter'
  .bind $scope, 'page'    

  $scope.showConfirm = (ev,userId) ->
    confirm = $mdDialog.confirm().title('Confirm Delete?').targetEvent(ev).ok('Yes').cancel('Cancel')
    $mdDialog.show(confirm).then (->
      $scope.deltimesheet(userId)
      return
    ), ->
      return
    return  

  $scope.resetFilter=()->
    $scope.userFilter= ''
    $scope.projectFilter= ''
  # console.log($scope.dailyLogs._id)

  $scope.deltimesheet=(dailylogid)->
    Meteor.call('deldailylog',dailylogid) 

  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = {name: parseInt($scope.orderProperty)}