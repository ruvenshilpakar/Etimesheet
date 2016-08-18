@NotAuthenticated = new Mongo.Collection('notAuthenticated')

NotAuthenticated.allow
  insert: (userId, notAuthenticated) ->
    userId
  update: (userId, notAuthenticated, fields, modifier) ->
    userId
  remove: (userId, notAuthenticated) ->
    userId
