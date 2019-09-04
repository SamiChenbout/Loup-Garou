LoverCouple.destroy_all
GameEvent.destroy_all
Message.destroy_all
Player.destroy_all
Game.destroy_all
Character.destroy_all
User.destroy_all

puts 'Seeding users...'
user1 = User.new(username: "hugo_pur100", email: "User1@mail.fr", password: "password", level: 7, description: "Veternensi, patre Constantio Constantini fratre imperatoris, matreque Galla sorore Rufini et Cerealis, quos trabeae consulares nobilitarunt et praefecturae.")
user1.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567604820/pur100_jbviyj.png"
user2 = User.new(username: "maya2024", email: "User2@mail.fr", password: "password", level: 5, description: "apud Tuscos in Massa Veternensi, patre Constantio Constantini fratre imperatoris, matreque Galla sorore Rufini et Cerealis, quos trabeae consulares nobilitarunt et praefecturae.")
user2.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567605047/46993537_z2dsvh.jpg"
user3 = User.new(username: "HubertEats", email: "User3@mail.fr", password: "password", level: 3, description: "Lorem inmaturo interitu ipse quoque sui pertaesus excessit e vitaet praefecturae.")
user3.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567605004/cf2elxghbxeeahy4eanr_nkq7n5.jpg"
user4 = User.new(username: "SamiBabi", email: "User4@mail.fr", password: "password", level: 5, description: "inmaturo interitu ipse quoque sui pertaesus excessit e vita aetatis nono anno atque vicensimo et praefecturae.")
user4.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567604931/52137839_srwwob.jpg"
user5 = User.new(username: "CarloScobar", email: "User5@mail.fr", password: "password", level: 2, description: "Plata o Plomo ?")
user5.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567605098/51363551_tzxpyx.png"
user6 = User.new(username: "St-Germain", email: "user6@mail.fr", password: "password", level: 6, description: "Veternensi, patre Constantio Constantini fratre imperatoris, matreque Galla sorore Rufini et Cerealis, quos trabeae consulares nobilitarunt et praefecturae.")
user6.remote_photo_url = "https://res.cloudinary.com/sami-chenbout/image/upload/v1567605181/b5yabm9mrg50xc4eyqt8_gjoghj.jpg"

user1.save
user2.save
user3.save
user4.save
user5.save
user6.save
puts 'Users seeded!'

puts 'Seeding characters...'
loup1 = Character.new(name: "loup", description: "Chaque nuit, ils égorgent une victime. Le jour, ils se font passer pour des villageois afin de ne pas être démasqués.")
loup1.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/08/18/813700_zoo_512x512.png"
loup2 = Character.new(name: "loup", description: "Chaque nuit, ils égorgent une victime. Le jour, ils se font passer pour des villageois afin de ne pas être démasqués.")
loup2.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/08/18/813700_zoo_512x512.png"
voyante = Character.new(name: "voyante", description: "Chaque nuit, elle peut espionner un joueur et découvrir sa véritable identité. Mieux vaut ne pas etre son ennemi...")
voyante.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/26/835620_wizard_512x512.png"
sorciere = Character.new(name: "sorciere", description: "Adepte de magie noire, elle dispose d'une potion de mort pour assassiner quelqu'un au premier tour.")
sorciere.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/26/835624_halloween_512x512.png"
chasseur = Character.new(name: "chasseur", description: "A sa mort, il doit éliminer un joueur en utilisant sa dernière balle. Reste à savoir s'il sait bien viser...")
chasseur.remote_photo_url = "https://www.shareicon.net/data/128x128/2017/01/06/868309_arrow_512x512.png"
cupidon = Character.new(name: "cupidon", description: "Dès le début de la partie, il doit former un couple de deux joueurs. Leur objectif sera de survivre ensemble, car si l'un d'eux meurt, l'autre se suicidera.")
cupidon.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/02/824449_love_512x512.png"

loup1.save
loup2.save
voyante.save
sorciere.save
chasseur.save
cupidon.save
puts 'Characters seeded!'

puts 'Seeding a game...'
game = Game.new
game.save
puts 'Game seeded!'

puts 'Seeding players...'
player1 = Player.new(user: user1, character: loup1, game: game)
player2 = Player.new(user: user2, character: loup2, game: game)
player3 = Player.new(user: user3, character: voyante, game: game)
player4 = Player.new(user: user4, character: chasseur, game: game)
player5 = Player.new(user: user5, character: sorciere, game: game)


player1.save
player2.save
player3.save
player4.save
player5.save
puts 'Players seeded!'

puts "The Game ID is : #{game.id}"

puts 'Seed has been done'
