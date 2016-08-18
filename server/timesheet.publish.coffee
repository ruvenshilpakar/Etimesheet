'use strict'

Meteor.publish 'timesheet', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfTimesheet', Timesheet.find(where), noReady: true
  Timesheet.find where, options