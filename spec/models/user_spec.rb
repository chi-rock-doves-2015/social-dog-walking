require "spec_helper"
RSpec.describe User, type: :model do

  let!(:gaber) {User.create!(petname: "Gaber", breed: "pomeranian", email: 'gaber2@gaber.com', password: 'password')}

  it 'is a user' do
    expect(gaber).to be_instance_of(User)
  end
end
