LoverCouple.destroy_all
GameEvent.destroy_all
Message.destroy_all
Player.destroy_all
Game.destroy_all
Character.destroy_all
User.destroy_all

URL = "https://source.unsplash.com/random"

puts 'Seeding users...'
user1 = User.new(username: "User1", email: "User1@mail.fr", password: "password")
user1.remote_photo_url = URL
sleep(4)
user2 = User.new(username: "User2", email: "User2@mail.fr", password: "password")
user2.remote_photo_url = URL
sleep(4)
user3 = User.new(username: "User3", email: "User3@mail.fr", password: "password")
user3.remote_photo_url = URL
sleep(4)
user4 = User.new(username: "User4", email: "User4@mail.fr", password: "password")
user4.remote_photo_url = URL
sleep(4)
user5 = User.new(username: "User5", email: "User5@mail.fr", password: "password")
user5.remote_photo_url = URL
user6 = User.new(username: "User6", email: "user6@mail.fr", password: "password")
user6.remote_photo_url = "https://cache.cosmopolitan.fr/data/photo/w1000_c17/3y/femme_sourire.jpg"

user1.save
user2.save
user3.save
user4.save
user5.save
user6.save
puts 'Users seeded!'

puts 'Seeding characters...'
loup1 = Character.new(name: "loup", description: "Ils se réveillent chaque nuit pour éliminer un villageois. Le jour, ils participent aux débats en essayant de ne pas faire découvrir leur activité nocturne. Ils ont le droit de voter comme tous les autres joueurs (car personne ne sait qui ils sont), et éventuellement contre un des leurs par nécessité.")
loup1.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/08/18/813700_zoo_512x512.png"
loup2 = Character.new(name: "loup", description: "Ils se réveillent chaque nuit pour éliminer un villageois. Le jour, ils participent aux débats en essayant de ne pas faire découvrir leur activité nocturne. Ils ont le droit de voter comme tous les autres joueurs (car personne ne sait qui ils sont), et éventuellement contre un des leurs par nécessité.")
loup2.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/08/18/813700_zoo_512x512.png"
voyante = Character.new(name: "voyante", description: "Au début de chaque nuit, elle peut désigner une personne dont elle découvrira secrètement l'identité. Si vous êtes vous-même la voyante, ne vous dévoilez pas trop vite sous peine de vous faire tuer au cours de la prochaine nuit par les loups-garous !")
voyante.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/26/835620_wizard_512x512.png"
sorciere = Character.new(name: "sorciere", description: "Elle possède une potion d'empoisonnement. Elle ne peut l'utiliser qu'une seule fois, au cours de la première nuit, pour tenter de tuer un loup. Après coup, elle n'est plus qu'une simple villageoise.")
sorciere.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/26/835624_halloween_512x512.png"
chasseur = Character.new(name: "chasseur", description: "Le chasseur n'a aucun rôle particulier à jouer tant qu'il est vivant. Mais dès qu'il meurt – qu'il soit tué dans la nuit (Loups-garous, sorcière), à la suite d'une décision des villageois ou par la mort de son amoureux — il doit désigner une personne qui mourra également, sur-le-champ.")
chasseur.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/02/824449_love_512x512.png"
cupidon = Character.new(name: "cupidon", description: "Durant la nuit du premier tour de la partie (tour préliminaire), il va désigner deux personnes qui seront amoureuses jusqu'à la fin du jeu. Il peut choisir n’importe quels joueurs, y compris se désigner lui-même. Si l'une des deux personnes vient à mourir, l'autre meurt immédiatement de désespoir.")
cupidon.remote_photo_url = "https://www.shareicon.net/data/128x128/2016/09/02/824442_music_512x512.png"

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

puts 'Seed has been done'
