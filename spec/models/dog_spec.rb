require 'rails_helper'

RSpec.describe Dog, type: :model do
	let!(:gaber) {User.create!(username: "Gaber", email: 'gaber2@gaber.com', password: 'password')}
	let!(:scruffy) {Dog.create!(name: 'Scruffy', breed: 'pomeranian', birthday: Time.now, owner: gaber )}
 	it "creates an instance of a dog" do 
 		expect(scruffy).to be_instance_of(Dog)
 	end
end
