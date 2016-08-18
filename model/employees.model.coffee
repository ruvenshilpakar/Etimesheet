@Employees = new Mongo.Collection('employees')

Employees.allow
  insert: (userId, employee) ->
    userId
  update: (userId, employee, fields, modifier) ->
    userId
  remove: (userId, employee) ->
    userId
