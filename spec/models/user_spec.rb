require "rails_helper"

RSpec.describe User, type: :model do

  let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password', image_url:http:'//ct.fra.bz/i60/2/11/15/f_bb089a2c01.jpg')}

  it 'is a user' do
    expect(gaber).to be_instance_of(User)
  end
end
