'use strict'

Meteor.publish 'notAuthenticated', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfNotAuthenticated', NotAuthenticated.find(where), noReady: true
  NotAuthenticated.find where, options