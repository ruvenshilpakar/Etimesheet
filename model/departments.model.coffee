@Departments = new Mongo.Collection('departments')

Departments.allow
  insert: (userId, department) ->
    userId
  update: (userId, department, fields, modifier) ->
    userId
  remove: (userId, department) ->
    userId
