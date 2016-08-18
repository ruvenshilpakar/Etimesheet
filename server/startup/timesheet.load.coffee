Meteor.startup ->
  if Timesheet.find().count() == 0
    timesheet = [
      {
        'name': 'timesheet 1'
      }
      {
        'name': 'timesheet 2'
      }
    ]
    timesheet.forEach (timesheet) ->
      Timesheet.insert timesheet