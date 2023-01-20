require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {User.create!(email: "missday@newgirl.com", password: "ilovecrafts", password_confirmation: "ilovecrafts", first_name: "Jessica", last_name: "Day")}

  let!(:admin_user) {User.new(email: 'sample@email.com', password: 'abc', first_name: 'Jessica', last_name: 'Day', role: 1)}

  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many(:items).dependent(:destroy) }
  end

  describe 'roles' do
    it "can be created as an admin" do
      expect(admin_user.role).to eq("admin")
      expect(admin_user.admin?).to be_truthy
    end

    it "can be created as a default user" do
      user = User.create(email: 'sample@email.com', password: 'abc', first_name: 'Jessica', last_name: 'Day', role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy
    end
  end 
    
  describe 'api_creation callback' do 
    it 'creates an api key for an admin but not default users' do 
      expect{ admin_user.save }.to change{ admin_user.api_key }
      expect{ user.save }.to_not change{ user.api_key }
    end
  end

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
