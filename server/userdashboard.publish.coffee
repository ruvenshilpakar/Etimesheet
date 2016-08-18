'use strict'

Meteor.publish 'userdashboard', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfUserdashboard', Userdashboard.find(where), noReady: true
  Userdashboard.find where, options