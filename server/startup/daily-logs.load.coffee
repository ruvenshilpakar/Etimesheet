Meteor.startup ->
  if DailyLogs.find().count() == 0
    dailyLogs = [
      {
        'name': 'dailyLog 1'
      }
      {
        'name': 'dailyLog 2'
      }
    ]
    dailyLogs.forEach (dailyLog) ->
      DailyLogs.insert dailyLog