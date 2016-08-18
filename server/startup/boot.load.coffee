oAuthSettings = [
  {
    'service': 'facebook'
    'appId': '374879386051476'
    'secret': 'c8fc585979af6a2d2933fd6faf12a150'
  }
  {
    'service': 'twitter'
    'consumerKey': 'BcmRPYFPavmMldDDs4pMonwr2'
    'secret': 'NjwC59ch1eoLoG2J5EldIoy5zHKvp6NOpbtZ8NxnLyz5wsyKwI'
  }
  {
    'service': 'google'
    'clientId': '702545809178-fdsdbs8p1l4t5o68bfb9forg025ef5eb.apps.googleusercontent.com'
    'secret': 'cWHM6qih_oY7jPaySBr0hIZh'
  }

]

Meteor.startup ->
  Accounts.loginServiceConfiguration.remove {}, ->
    for eachKey in oAuthSettings
      Accounts.loginServiceConfiguration.insert(eachKey);
