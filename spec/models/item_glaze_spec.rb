require 'rails_helper'

RSpec.describe ItemGlaze, type: :model do 
  describe 'validations' do 
    it { should validate_presence_of(:layers)}
    it { should validate_presence_of(:item_id)}
    it { should validate_presence_of(:glaze_id)}
  end

  describe 'relationships' do 
    it {should belong_to(:item) }
    it {should belong_to(:glaze) }
  end
end