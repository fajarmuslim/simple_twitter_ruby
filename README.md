# Simple Twitter Ruby

### Scope:
Your application will be an API-only application with the following stories:
1. As a user, I want to save my username, email, and bio description.
* Authentication and authorization is out of scope of this story and you don’t need to implement them
2. As a user, I want to post a text that might contain hashtag(s).
* Maximum limit of a text is 1000 characters
* A hashtag is a text that is followed by # symbol, for instance: #generasigigih
3. As a user, I want to see all posts that contain a certain hashtag.
* A user can only filter by one hashtag at a time
4. As a user, I want to see the list of trending hashtags.
* Trending hashtags are the top 5 most posted hashtags in the past 24 hours
* A post containing multiple instances of a hashtag only counts as 1 occurrence for trending hashtags calculation
5. As a user, I want to comment on a post
* A comment can contain hashtag(s)
* A hashtag occurrence in a comment is counted in trending hashtags calculation
6. As a user, I want to attach things to a post
* Three kinds of attachment are allowed: pictures (jpg, png, gif), video (mp4), and file (any other extensions outside of pictures and videos)

### Requirement
* Ruby
* Sinatra
* Mysql
* Ansible

### Run local
Clone 
```bash
git clone https://github.com/fajarmuslim/simple_twitter_ruby.git
```

Navigate to project dir
```bash
cd simple_twitter_ruby
```

Import database
```bash
mysql -u {username} -p {databasename} < {filename.sql}
```

Set db config in
`db/mysql_connector.rb`

Run app
```bash
ruby main.rb
```

### Currently the deployed app
```bash
http://34.101.197.203:4567/
```

I have add the postman collection to try app in this repo. you may follow instruction to import postman collection in this [link](https://kb.datamotion.com/?ht_kb=postman-instructions-for-exporting-and-importing)

### Acknowledgment
* Gojek
* YABB
* Generasi GIGIH
