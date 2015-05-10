require "rails_helper"

RSpec.describe Mark, type: :model do

  let!(:josh) {User.create!(username: "josh", email: 'josh@josh.com', password: 'password')}
  let!(:walk_one) {Walk.create!(user: josh)}
  let!(:mark_one) {Mark.create!(latitude: 40.6892, longitude: 74.0444, accuracy: 30, walk: walk_one)}
  it 'is an instance of mark' do
    expect(mark_one).to be_instance_of(Mark)
  end

  it 'has an association called walk' do 
  	expect(mark_one.walk).to eq(walk_one)
  end

  it 'will return an ordered string of marks in json' do 
  	expect(JSON.parse(Mark.ordered_json)).to be_instance_of(Array)
  end
end

