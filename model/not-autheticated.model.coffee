@NotAutheticated = new Mongo.Collection('notAutheticated')

NotAutheticated.allow
  insert: (userId, notAutheticated) ->
    userId
  update: (userId, notAutheticated, fields, modifier) ->
    userId
  remove: (userId, notAutheticated) ->
    userId
