Meteor.startup ->
  process.env.MAIL_URL="smtp://mist3st.zzz%40gmail.com:testaccount@smtp.gmail.com:465/";
  Accounts.emailTemplates.resetPassword.text = (user, url) ->
    url = url.replace('#/','')

  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    url = url.replace('#/','')

  if Meteor.users.find().count() == 0
    Accounts.createUser({
        email: 'admin@admin.com'
        password: 'admin'
        profile:{
          role: 'admin'
        }
      })