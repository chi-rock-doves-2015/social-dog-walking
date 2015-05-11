require 'rails_helper'

feature 'user can take a walk' do 
	walk_link = 'Take a walk'
	walk_page_content = 'Current walk stats'
	let!(:user) {User.create!(username: "user", email: 'user@user.com', password: 'password')}

	before do 
    visit '/login'
    login_form = page.all('form#login_form')
    fill_in 'Password', with: 'password'
    fill_in 'Email', with: 'user@user.com'
    within login_form[0] do 
      click_button('')
    end
  end 

	xscenario 'walk link exists' do
		links = page.all('a', text: walk_link)
		links.each do |link|
		 	puts link.text
		end
		click_link(walk_link)
		has_link(walk_link)
		expect(page).to have_content walk_page_content
	end

	# scenario 'link takes you to the walk page' do 

	# 	expect(page).to have_content walk_page_content
	# end
end