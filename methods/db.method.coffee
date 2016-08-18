'use strict'

Meteor.methods
  deldailylog:(dailylogid)->
    DailyLogs.update(dailylogid,{$set:'deleted':1})
    
    
  approveLeave:(leaveRequestid)->
    LeaveRequests.update(leaveRequestid,{$set:{'status':"Approved"}})
    

  discardLeave:(leaveRequestid)->
    LeaveRequests.update(leaveRequestid,{$set:{'status':"Cancelled"}})
    

  cancelLeaveRequest:(leaveRequestid)->
    LeaveRequests.update(leaveRequestid,{$set:{'deleted':1}})
    
      
  remove: (user) ->
    Meteor.users.update({ _id: user },{$set:{"profile.deleted":1}})
    

  deactivate: (user) ->
    Meteor.users.update({ _id: user },{$set:{"profile.isActive":0}})
    

  activate: (user) ->
    Meteor.users.update({ _id: user },{$set:{"profile.isActive":1}})
    Meteor.users.update({ _id: user },{$set:{"emails.0.verified":true}})
    
    

  projectDelete:(project) ->
    Projects.update(project,{$set:{'deleted':1}})

  updateDesignation:(designationId) ->
    Designations.update(designationId,{$set:{'deleted':1}})

  departmentDelete:(departmentId) ->
    Departments.update(departmentId,{$set:{'deleted':1}})  

  organizationDelete:(organizationId) ->
    Organizations.update(organizationId,{$set:{'deleted':1}})


  update:(user, fName, mName, lName, mobileNum,homeNum,address,department,designation) ->
    Meteor.users.update({ _id: user },{$set:{"profile.fName":fName}})
    Meteor.users.update({ _id: user },{$set:{"profile.mName":mName}})
    Meteor.users.update({ _id: user },{$set:{"profile.lName":lName}})
    Meteor.users.update({ _id: user },{$set:{"profile.contact.0.mobileNum":mobileNum}})
    Meteor.users.update({ _id: user },{$set:{"profile.contact.0.homeNum":homeNum}})
    Meteor.users.update({ _id: user },{$set:{"profile.address":address}})
    Meteor.users.update({ _id: user },{$set:{"profile.department":department}})
    Meteor.users.update({ _id: user },{$set:{"profile.designation":designation}})



