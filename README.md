# README

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.0]
- Rails [6.0.2.2]
- Sidekiq
- PostgreSQL


##### Endpoinds

```bash
1) http://localhost:3000/api/v1/movies_seasons?page=1

VERB GET

Mandatory in HEADERS

API_TOKEN
USER_AUTH_TOKEN

2) http://localhost:3000/api/v1/seasons

VERB GET

Mandatory in HEADERS

API_TOKEN
USER_AUTH_TOKEN

3) http://localhost:3000/api/v1/movies_seasons

VERB GET

Mandatory in HEADERS

API_TOKEN
USER_AUTH_TOKEN

4) http://localhost:3000/api/v1/libraries

VERB POST

Mandatory in HEADERS

API_TOKEN
USER_AUTH_TOKEN
purchase: it is a id of the resource comes from the frontend

5) http://localhost:3000/api/v1/libraries

VERB GET

Mandatory in HEADERS

API_TOKEN
USER_AUTH_TOKEN
```

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

##### 5. Create data

```ruby
bundle exec rake db:seed
```

##### 6. Testing Rspec

```ruby
rspec spec
```

##### 7. Rake for checking caducated purchases

```ruby
bundle exec rake checking_caducated_wachings:library
```

##### 8. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000