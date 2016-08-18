'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'dailyLogs-list',
    url: '/daily-logs'
    templateUrl: 'client/daily-logs/daily-logs-list.view.html'
    controller: 'DailyLogsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'dailyLog-detail',
    url: '/daily-logs/:dailyLogId'
    templateUrl: 'client/daily-logs/daily-log-detail.view.html'
    controller: 'DailyLogDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
