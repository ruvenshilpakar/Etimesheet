@Timesheet = new Mongo.Collection('timesheet')

Timesheet.allow
  insert: (userId, timesheet) ->
    userId
  update: (userId, timesheet, fields, modifier) ->
    userId
  remove: (userId, timesheet) ->
    userId
