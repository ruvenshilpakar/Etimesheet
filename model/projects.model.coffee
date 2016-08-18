@Projects = new Mongo.Collection('projects')

Projects.allow
  insert: (userId, project) ->
    userId
  update: (userId, project, fields, modifier) ->
    userId
  remove: (userId, project) ->
    userId
