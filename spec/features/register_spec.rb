require 'rails_helper'

feature 'user registration' do
	scenario 'sees the form after visiting the registration page' do 
		visit '/users/new'
		expect(page).to have_content "Register"
	end 

	scenario 'will return error if password is blank' do 
		visit '/users/new'
		registration_form = page.all('form#registration_form')
		fill_in 'Username', with: 'josh'
		fill_in 'Email', with: 'josh@josh.com'
    within registration_form[0] do 
      click_button('')
    end
    expect(page).to have_content "Password can't be blank"
	end

	scenario '' do 
	end
end