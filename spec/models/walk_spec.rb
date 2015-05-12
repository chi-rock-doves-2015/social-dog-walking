require "rails_helper"


RSpec.describe Walk, type: :model do

  let!(:josh) {User.create!(username: "josh", email: 'josh@josh.com', password: 'password')}
  let!(:walk_one) {Walk.create!(user: josh)}
  let!(:mark_one) {Mark.create!(coords: 'POINT(40.6892  74.0444)', accuracy: 30, walk: walk_one)}
  it 'is an instance of mark' do
    expect(walk_one).to be_instance_of(Walk)
  end

  it 'has an association called marks' do
  	expect(walk_one.marks.last).to eq(mark_one)
  end
end
