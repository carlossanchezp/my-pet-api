# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Users examples
User.create(email: "carmen@example.com")
User.create(email: "carlos@example.com")
User.create(email: "alfredo@example.com")

## Movies examples
Movie.create(title: "Title movie 1", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
Movie.create(title: "Title movie 2", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
Movie.create(title: "Title movie 3", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
Movie.create(title: "Title movie 4", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")

## Season examples
season1=Season.create(title: "Title season 1", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season2=Season.create(title: "Title season 2", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season3=Season.create(title: "Title season 3", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season4=Season.create(title: "Title season 4", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season5=Season.create(title: "Title season 4", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season6=Season.create(title: "Title season 4", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")
season7=Season.create(title: "Title season 4", plot: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.")

## Episodes examples

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet", num_episode: 1, season: season1)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet", num_episode: 2,season: season1)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet", num_episode: 3,season: season1)

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season2)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season2)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season2)


Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season3)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season3)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season3)

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season4)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season4)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season4)

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season5)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season5)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season5)

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season6)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season6)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season6)

Episode.create(title: "EPISODE 1", plot: "Lorem ipsum dolor sit amet",  num_episode: 1,season: season7)
Episode.create(title: "EPISODE 2", plot: "Lorem ipsum dolor sit amet",  num_episode: 2,season: season7)
Episode.create(title: "EPISODE 3", plot: "Lorem ipsum dolor sit amet",  num_episode: 3,season: season7)
