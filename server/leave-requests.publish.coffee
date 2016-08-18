'use strict'

Meteor.publish 'leaveRequests', (options,dataOwner, searchString) ->
  where =
    'reason':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
    'ownerId' : dataOwner.ownerId
    'deleted':0
  Counts.publish this, 'numberOfLeaveRequests', LeaveRequests.find(where), noReady: true
  LeaveRequests.find where, options

Meteor.publish 'leaveRequestsAdmin', (options, searchString) ->
  where =
    'requestedBy':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
    'deleted':0
    'status': 'Pending'
  Counts.publish this, 'numberOfLeaveRequests', LeaveRequests.find(where), noReady: true
  LeaveRequests.find where, options

Meteor.publish 'allLeaveRequestsAdmin', (options, searchString, statusSearch) ->
  where =
    'requestedBy':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
    'status':
      '$regex': '.*' + (statusSearch or '') + '.*'
      '$options': 'i'
    'deleted':0
  Counts.publish this, 'numberOfAllLeaveRequests', LeaveRequests.find(where), noReady: true
  LeaveRequests.find where, options