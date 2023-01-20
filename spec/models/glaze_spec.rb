require 'rails_helper'

RSpec.describe Glaze, type: :model do 
  describe 'validations' do 
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:brand)}
  end

  describe 'relationships' do 
    it {should have_many(:item_glazes) }
    it {should have_many(:items).through(:item_glazes) }
  end
end