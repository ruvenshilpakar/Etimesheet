Meteor.startup ->
  if LeaveRequests.find().count() == 0
    leaveRequests = [
      {
        'name': 'leaveRequest 1'
      }
      {
        'name': 'leaveRequest 2'
      }
    ]
    leaveRequests.forEach (leaveRequest) ->
      LeaveRequests.insert leaveRequest