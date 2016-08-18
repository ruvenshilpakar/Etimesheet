@Organizations = new Mongo.Collection('organizations')

Organizations.allow
  insert: (userId, organization) ->
    userId
  update: (userId, organization, fields, modifier) ->
    userId
  remove: (userId, organization) ->
    userId
