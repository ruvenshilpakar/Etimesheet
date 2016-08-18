Meteor.startup ->
  if NotAuthenticated.find().count() == 0
    notAuthenticated = [
      {
        'name': 'notAuthenticated 1'
      }
      {
        'name': 'notAuthenticated 2'
      }
    ]
    notAuthenticated.forEach (notAuthenticated) ->
      NotAuthenticated.insert notAuthenticated