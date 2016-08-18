Meteor.startup ->
  if Organizations.find().count() == 0
    organizations = [
      {
        'name': 'organization 1'
      }
      {
        'name': 'organization 2'
      }
    ]
    organizations.forEach (organization) ->
      Organizations.insert organization