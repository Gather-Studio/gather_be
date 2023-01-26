#### USERS 
require 'factory_bot_rails'


5.times {FactoryBot.create(:user)}

def random_user
  User.all.pluck(:id).sample
end

items = 20.times {FactoryBot.create(:item, user_id: random_user)}

vase = FactoryBot.create(:item, name: "Vase", user_id: random_user)
spoon = FactoryBot.create(:item, name: "Spoon", user_id: random_user)
cat_bowl = FactoryBot.create(:item, name: "Cat Bowl", user_id: random_user)
plate = FactoryBot.create(:item, name: "Plate", user_id: random_user)
bowl = FactoryBot.create(:item, name: "Soup Bowl", user_id: random_user)

admin = User.create!(email: "admin@gmail.com",
                     password: "rubyisfun",
                     password_confirmation: "rubyisfun",
                     first_name: "Example",
                     last_name: "Admin",
                     role: 1)

honey_flux = Glaze.create!(name: "Honey Flux", brand: "Amaco")
blue_rutile = Glaze.create!(name: "Blue Rutile", brand: "Amaco")
rainforest = Glaze.create!(name: "Rainforest", brand: "Amaco")
snow = Glaze.create!(name: "Snow", brand: "Amaco")
cinnabar = Glaze.create!(name: "Cinnabar", brand: "Mayco")
oyster = Glaze.create!(name: "Oyster", brand: "Mayco")

# vase.item_glazes.create!(glaze: rainforest, layers: 2)
# vase.item_glazes.create!(glaze: snow, layers: 1)

# spoon.item_glazes.create!(glaze: blue_rutile, layers: 3)

# fork.item_glazes.create!(glaze: blue_rutile, layers: 3)

# knife.item_glazes.create!(glaze: blue_rutile, layers: 2)
# knife.item_glazes.create!(glaze: snow, layers: 2)

# bowl.item_glazes.create!(glaze: cinnabar, layers: 1)
# bowl.item_glazes.create!(glaze: oyster, layers: 1)

# plate.item_glazes.create!(glaze: oyster, layers: 2)

# cat_bowl.item_glazes.create!(glaze: blue_rutile, layers: 1)
# cat_bowl.item_glazes.create!(glaze: snow, layers: 1)

