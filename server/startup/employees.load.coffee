Meteor.startup ->
  if Employees.find().count() == 0
    employees = [
      {
        'name': 'employee 1'
      }
      {
        'name': 'employee 2'
      }
    ]
    employees.forEach (employee) ->
      Employees.insert employee

  