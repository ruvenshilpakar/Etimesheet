@DailyLogs = new Mongo.Collection('dailyLogs')

DailyLogs.allow
  insert: (userId, dailyLog) ->
    true
  update: (userId, dailyLog, fields, modifier) ->
    true
  remove: (userId, dailyLog) ->
    true
