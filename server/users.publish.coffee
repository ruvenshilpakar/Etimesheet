'use strict'

Meteor.publish 'users', (options, searchString) ->
  where =
      'profile.fName':
        '$regex': '.*' + (searchString or '') + '.*'
        '$options': 'i'
      'profile.deleted' : 0 
  Counts.publish this, 'numberOfUsers', Meteor.users.find(where), noReady: true
  Meteor.users.find where, options