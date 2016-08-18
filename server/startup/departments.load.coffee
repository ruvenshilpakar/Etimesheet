Meteor.startup ->
  if Departments.find().count() == 0
    departments = [
      {
        'name': 'department 1'
      }
      {
        'name': 'department 2'
      }
    ]
    departments.forEach (department) ->
      Departments.insert department