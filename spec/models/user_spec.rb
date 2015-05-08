require "spec_helper"
describe User do

  let!(:gaber) {User.create!(petname: "Gaber", breed: "pomeranian", email: 'gaber@gaber.com', password: 'password')}

  it 'is a user' do
    expect(gaber).to be_instance_of(User)
  end
end
