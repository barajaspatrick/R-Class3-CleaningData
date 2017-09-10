library(httr)



# 1. Find OAuth settings for github:

#    http://developer.github.com/v3/oauth/

oauth_endpoints("github")



# 2. To make your own application, register at at

#    https://github.com/settings/applications. Use any URL for the homepage URL

#    (http://github.com is fine) and  http://localhost:1410 as the callback url

#

#    Replace your key and secret below.

myapp <- oauth_app("github",
                   
                   key = "2d823892d892a15e42e1",
                   
                   secret = "45d81105d94640948aaa3b8552b5185db1f9453b")



# 3. Get OAuth credentials

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)



# 4. Use API

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)

content(req)