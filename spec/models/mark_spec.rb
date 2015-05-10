require "rails_helper"

RSpec.describe Walk, type: :model do

  let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password')}
  let!(:walk_one) {Walk.create!(user: gaber)}
  let!(:mark_one) {Mark.create!(latitude: 40.6892, longitude: 74.0444, accuracy: 30, walk: walk_one)}
  it 'is an instance of walk' do
    expect(walk_one).to be_instance_of(Walk)
  end

  it 'has an active record relation called marks with all marks that are associated with it' do 
  	expect(walk_one.marks.last).to eq(mark_one)
  end
end

RSpec.describe Mark, type: :model do


  let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password')}
  let!(:walk_one) {Walk.create!(user: gaber)}
  let!(:mark_one) {Mark.create!(latitude: 40.6892, longitude: 74.0444, accuracy: 30, walk: walk_one)}
  it 'is an instance of mark' do
    expect(mark_one).to be_instance_of(Mark)
  end


  it 'has an active record relation called walk that returns the walk that the mark belongs to' do 
  	expect(mark_one.walk).to eq(walk_one)
  end
end

