# README

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.0]
- Rails [6.0.2.2]

##### 1. Check out the repository

```bash
git@github.com:carlossanchezp/my-pet-api.git
```


##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```
##### 4. Cleaning all database and start

```ruby
bundle exec rake db:reset
```

##### 5. Testing Rspec

```ruby
rspec spec
```

##### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000