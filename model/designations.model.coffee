@Designations = new Mongo.Collection('designations')

Designations.allow
  insert: (userId, designation) ->
    userId
  update: (userId, designation, fields, modifier) ->
    userId
  remove: (userId, designation) ->
    userId
