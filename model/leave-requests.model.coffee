@LeaveRequests = new Mongo.Collection('leaveRequests')

LeaveRequests.allow
  insert: (userId, leaveRequest) ->
    userId
  update: (userId, leaveRequest, fields, modifier) ->
    userId
  remove: (userId, leaveRequest) ->
    userId
