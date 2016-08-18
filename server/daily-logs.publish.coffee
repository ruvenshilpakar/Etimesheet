'use strict'

Meteor.publish 'dailyLogs', (options, searchString, projectFilter) ->
  where =
    'createdBy':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
    'deleted': 0 
    'projectName':
      '$regex': '.*' + (projectFilter or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfDailyLogs', DailyLogs.find(where), noReady: true
  DailyLogs.find where, options