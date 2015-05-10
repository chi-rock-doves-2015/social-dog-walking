require 'rails_helper'

RSpec.describe Dog, type: :model do
  let!(:josh) {User.create!(username: "josh", email: 'josh@josh.com', password: 'password')}
  let!(:scruffy) {Dog.create!(name: 'Scruffy', breed: 'Cocker Spaniel', birthday: "July 10, 2006", owner: josh)}
  let(:sparky) {Dog.new(name: 'Sparky', breed: 'Great Dane', birthday: "June 9, 2005")}
	it 'is an instance of dog' do 
		expect(scruffy).to be_instance_of(Dog)
	end

	it 'has an association called owner' do  
		expect(scruffy.owner).to eq(josh)
	end

	it 'will not save without an owner' do
		expect(sparky.save).to be(false)
	end
end
