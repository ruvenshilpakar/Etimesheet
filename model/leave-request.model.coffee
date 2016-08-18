@LeaveRequest = new Mongo.Collection('leaveRequest')

LeaveRequest.allow
  insert: (userId, leaveRequest) ->
    userId
  update: (userId, leaveRequest, fields, modifier) ->
    userId
  remove: (userId, leaveRequest) ->
    userId
