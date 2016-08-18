Meteor.startup ->
  if Projects.find().count() == 0
    projects = [
      {
        'name': 'project 1'
      }
      {
        'name': 'project 2'
      }
    ]
    projects.forEach (project) ->
      Projects.insert project