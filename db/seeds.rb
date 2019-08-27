# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Character.destroy_all
Player.destroy_all
Game.destroy_all
User.destroy_all

Character.new(name: "loup", description: "Il est méchant").save
Character.new(name: "loup", description: "Il est méchant").save
Character.new(name: "voyante", description: "Il est gentil").save
Character.new(name: "sorciere", description: "Il est gentil").save
Character.new(name: "chasseur", description: "Il est chiant").save
Character.new(name: "cupîdon", description: "Il est gniangnian").save


















puts 'Creating first user...'
user_1 = User.create!({
  username: "hubert1",
  email: "hubert1@mail.me",
  password: "password"
})

puts 'Creating second user...'
user_2 = User.create!({
  username: "hubert2",
  email: "hubert2@mail.me",
  password: "password"
})

puts 'Creating a game...'
game_1 = Game.create!()

puts 'Creating first user corresponding player...'
Player.create!({
  user: user_1,
  game: game_1,
  character: Character.new(name: "loup", description: "Il est méchant")
})

puts 'Creating first corresponding player...'
Player.create!({
  user: user_2,
  game: game_1,
  character: Character.new(name: "chasseur", description: "Il est chiant")
})


puts 'Finished!'
