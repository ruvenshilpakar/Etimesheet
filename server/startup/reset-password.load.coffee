Meteor.startup ->
  if ResetPassword.find().count() == 0
    resetPassword = [
      {
        'name': 'resetPassword 1'
      }
      {
        'name': 'resetPassword 2'
      }
    ]
    resetPassword.forEach (resetPassword) ->
      ResetPassword.insert resetPassword