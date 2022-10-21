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

user2.items.create!(name: "Cat Bowl", 
                    status: 3, 
                    clay_body: "Porcelain", 
                    glazes: "Honeyflux x3 ", 
                    height: 10.0, 
                    width: 4.5, 
                    memo: "A regal bowl for Furguson ", 
                    style: "Wheel-Thrown")


