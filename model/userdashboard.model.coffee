@Userdashboard = new Mongo.Collection('userdashboard')

Userdashboard.allow
  insert: (userId, userdashboard) ->
    userId
  update: (userId, userdashboard, fields, modifier) ->
    userId
  remove: (userId, userdashboard) ->
    userId
