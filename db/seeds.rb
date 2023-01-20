#### USERS 

user1 = User.create!(email: "missday@newgirl.com", 
                    password: "ilovecrafts", 
                    password_confirmation: "ilovecrafts", 
                    first_name: "Jessica", 
                    last_name: "Day")

user2 = User.create!(email: "winston@newgirl.com",
                    password: "cats4lyfe",
                    password_confirmation: "cats4lyfe",
                    first_name: "Winston",
                    last_name: "Bishop")

            
user3 = User.create!(email: "nick@newgirl.com",
                    password: "clydesbar",
                    password_confirmation: "clydesbar",
                    first_name: "Nick",
                    last_name: "Miller")

admin = User.create!(email: "admin@gmail.com",
                     password: "rubyisfun",
                     password_confirmation: "rubyisfun",
                     first_name: "Example",
                     last_name: "Admin",
                     role: 1)
 
##### ITEMS

vase = user1.items.create!(name: "Vase", 
                    status: 0, 
                    clay_body: "Brown Speckle", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "It's a little wonky", 
                    style: "Wheel-Thrown")

spoon = user1.items.create!(name: "Spoon", 
                    status: 0, 
                    clay_body: "Red Clay", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "Gift for Nan", 
                    style: "Hand Built")

fork = user1.items.create!(name: "Fork", 
                    status: 1, 
                    clay_body: "Red Clay", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "To go with the spoon", 
                    style: "Hand Built")

knife = user1.items.create!(name: "Knife", 
                    status: 2, 
                    clay_body: "Red Clay", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "To go with the Fork", 
                    style: "Hand Built")

bowl = user1.items.create!(name: "Soup Bowl", 
                    status: 3, 
                    clay_body: "Red Clay", 
                    height: 7.0, 
                    width: 5.0, 
                    memo: "Almost a complete set", 
                    style: "Wheel-Thrown")

plate = user1.items.create!(name: "Plate", 
                    status: 4, 
                    clay_body: "Red Clay", 
                    height: 1.0, 
                    width: 10.0, 
                    memo: "Final Piece!", 
                    style: "Wheel-Thrown")

cat_bowl = user2.items.create!(name: "Cat Bowl", 
                    status: 3, 
                    clay_body: "Porcelain", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "A regal bowl for Furguson ", 
                    style: "Wheel-Thrown")


## GLAZES

honey_flux = Glaze.create!(name: "Honey Flux", brand: "Amaco")
blue_rutile = Glaze.create!(name: "Blue Rutile", brand: "Amaco")
rainforest = Glaze.create!(name: "Rainforest", brand: "Amaco")
snow = Glaze.create!(name: "Snow", brand: "Amaco")
cinnabar = Glaze.create!(name: "Cinnabar", brand: "Mayco")
oyster = Glaze.create!(name: "Oyster", brand: "Mayco")

vase.item_glazes.create!(glaze: rainforest, layers: 2)
vase.item_glazes.create!(glaze: snow, layers: 1)

spoon.item_glazes.create!(glaze: blue_rutile, layers: 3)

fork.item_glazes.create!(glaze: blue_rutile, layers: 3)

knife.item_glazes.create!(glaze: blue_rutile, layers: 2)
knife.item_glazes.create!(glaze: snow, layers: 2)

bowl.item_glazes.create!(glaze: cinnabar, layers: 1)
bowl.item_glazes.create!(glaze: oyster, layers: 1)

plate.item_glazes.create!(glaze: oyster, layers: 2)

cat_bowl.item_glazes.create!(glaze: blue_rutile, layers: 1)
cat_bowl.item_glazes.create!(glaze: snow, layers: 1)

