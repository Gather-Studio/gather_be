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

user1.items.create!(name: "Vase", 
                    status: 0, 
                    clay_body: "Brown Speckle", 
                    glazes: "Rainforest x2, Snow x1", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "It's a little wonky", 
                    style: "Wheel-Thrown")

user1.items.create!(name: "Spoon", 
                    status: 0, 
                    clay_body: "Red Clay", 
                    glazes: "Blue Rutile x2", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "Gift for Nan", 
                    style: "Hand Built")

user1.items.create!(name: "Fork", 
                    status: 1, 
                    clay_body: "Red Clay", 
                    glazes: "Blue Rutile x2", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "To go with the spoon", 
                    style: "Hand Built")

user1.items.create!(name: "Knife", 
                    status: 2, 
                    clay_body: "Red Clay", 
                    glazes: "Blue Rutile x2", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "To go with the Fork", 
                    style: "Hand Built")

user1.items.create!(name: "Soup Bowl", 
                    status: 3, 
                    clay_body: "Red Clay", 
                    glazes: "Blue Rutile x2", 
                    height: 7.0, 
                    width: 5.0, 
                    memo: "Almost a complete set", 
                    style: "Wheel-Thrown")

user1.items.create!(name: "Plate", 
                    status: 4, 
                    clay_body: "Red Clay", 
                    glazes: "Blue Rutile x2", 
                    height: 1.0, 
                    width: 10.0, 
                    memo: "Final Piece!", 
                    style: "Wheel-Thrown")

user2.items.create!(name: "Cat Bowl", 
                    status: 3, 
                    clay_body: "Porcelain", 
                    glazes: "Honeyflux x3 ", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "A regal bowl for Furguson ", 
                    style: "Wheel-Thrown")


