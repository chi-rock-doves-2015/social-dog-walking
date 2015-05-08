require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:gaber) {User.create!(pet_name: "Gaber", breed: "pomeranian", email: 'gaber@gaber.com', password: 'password')}
  it 'is a user' do
    expect(gaber).to be_instance_of(User)
  end
end


