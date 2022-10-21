require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.create(email: 'sample@email.com', password: 'abc', first_name: 'Jessica', last_name: 'Day') }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many(:items) }
  end
end
