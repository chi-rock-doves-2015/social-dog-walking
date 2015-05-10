require "rails_helper"

RSpec.describe User, type: :model do

  let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password')}
  let!(:walk_one) {Walk.create!(user: gaber)}
  let!(:mark_one) {Mark.create!(latitude: 40.6892, longitude: 74.0444, accuracy: 30, walk: walk_one)}
  it 'is an instance of mark' do
    expect(mark_one).to be_instance_of(Mark)
  end
end