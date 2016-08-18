Meteor.startup ->
  if Userdashboard.find().count() == 0
    userdashboard = [
      {
        'name': 'userdashboard 1'
      }
      {
        'name': 'userdashboard 2'
      }
    ]
    userdashboard.forEach (userdashboard) ->
      Userdashboard.insert userdashboard