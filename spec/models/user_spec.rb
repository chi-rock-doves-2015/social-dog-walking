require "rails_helper"

RSpec.describe User, type: :model do

  let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password')}
  it 'is a user' do
    expect(gaber).to be_instance_of(User)
  end
end
