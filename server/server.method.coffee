'use strict'
Meteor.methods
  resetPasswordAdmin: (userId, newPassword)->
    Accounts.setPassword(userId,newPassword)
    
  chkEmailVerify:(userId,emailToVerify) ->
    Accounts.sendVerificationEmail(userId,emailToVerify)