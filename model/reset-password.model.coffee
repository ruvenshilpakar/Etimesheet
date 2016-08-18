@ResetPassword = new Mongo.Collection('resetPassword')

ResetPassword.allow
  insert: (userId, resetPassword) ->
    true
  update: (userId, resetPassword, fields, modifier) ->
    true
  remove: (userId, resetPassword) ->
    true
