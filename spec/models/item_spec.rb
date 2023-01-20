require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  let!(:user) {User.create!(email: "missday@newgirl.com", password: "ilovecrafts", password_confirmation: "ilovecrafts", first_name: "Jessica", last_name: "Day")}

  let!(:item1) {user.items.create!(name: "Vase", status: 0, user_id: user.id)}
  let!(:item2) {user.items.create!(name: "Bowl", status: 1, user_id: user.id)}
  let!(:item3) {user.items.create!(name: "Cat Statue", status: 1, user_id: user.id)}
  let!(:item4) {user.items.create!(name: "Plate", status: 2, user_id: user.id)}

  describe '#filter_by_status(status)' do 
    it 'returns the items with the corresponding status' do 
      expect(Item.filter_by_status(0).count).to eq(1)
      expect(Item.filter_by_status(1).count).to eq(2)
      expect(Item.count).to eq(4)
    end
  end
end
