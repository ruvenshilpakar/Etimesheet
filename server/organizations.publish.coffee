'use strict'

Meteor.publish 'organizations', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
    'deleted': 0

  Counts.publish this, 'numberOfOrganizations', Organizations.find(where), noReady: true
  Organizations.find where, options