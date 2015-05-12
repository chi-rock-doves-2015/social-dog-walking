require "rails_helper"

RSpec.describe User, type: :model do


  let!(:josh) {User.create!(username: "josh", email: 'josh@josh.com', password: 'password')}
  let(:mortimer) {User.new(username: 'Mortimer', email: 'jim@jim.com', password: 'password', avatar_file_name: 'no such file', avatar_content_type: 'strings', avatar_file_size: '0px')}
  let(:travis) {User.new(username: "Travis", email: 'josh@josh.com', password: 'password')}
  let!(:scruffy) {Dog.create!(name: 'Scruffy', breed: 'Cocker Spaniel', birthday: "July 10, 2006", owner: josh)}
  let!(:sparky) {Dog.create!(name: 'Sparky', breed: 'Great Dane', birthday: "June 9, 2005", owner: josh)}
  let!(:walk_one) {Walk.create!(user: josh)}
  let!(:mark_one) {Mark.create!(coords: 'POINT(40.6892  74.0444)', accuracy: 30, walk: walk_one)}

  it 'is a user' do
    expect(josh).to be_instance_of(User)
  end

  it 'has an association of dogs' do
  	expect(josh.dogs.count).to eq(2)
  end

  it 'has an association of walks' do
  	expect(josh.walks.last).to be_instance_of(Walk)
  end

  it 'has an association of marks' do
  	expect(josh.marks.last).to be_instance_of(Mark)
  end

  it 'has an email field that must be unique' do
  	travis.save
  	expect(travis.errors.messages[:email][0]).to eq("has already been taken")
  end

  it 'has an error message of avatar invalid if wrong type of file is used' do
  	mortimer.save
  	expect(mortimer.errors.messages[:avatar][0]).to eq("is invalid")
  end
end
