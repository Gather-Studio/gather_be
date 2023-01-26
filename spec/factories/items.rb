  FactoryBot.define do
    factory :item do
      name { Faker::Lorem.word }
      style  { ["Wheel Thrown", "Hand Built"].sample }
      status { Item.statuses.values.sample }
      clay_body { ["Porcelain", "Red Clay", "Stoneware", "Earthenware"].sample }
      height { Faker::Number.between(from: 1, to: 10) }
      width { Faker::Number.between(from: 1, to: 10) }
      memo {Faker::TvShows::NewGirl.quote}
      user_id { 1 }
    end

    # def clay_bodies 
    #   ["Porcelain", "Red Clay", "Stoneware", "Earthenware"]
    # end

    # def style 
    #   ["Wheel Thrown", "Hand Built"]
    # end
  end