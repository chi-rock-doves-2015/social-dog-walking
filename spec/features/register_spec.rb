require 'rails_helper'


#need to come back and clean these up. A lot of repetition. 

feature 'user registration' do

	let!(:user) {User.create!(username: "user", email: 'user@user.com', password: 'password')}

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

	scenario 'will return error if email is blank' do 
		visit '/users/new'
		registration_form = page.all('form#registration_form')
		fill_in 'Username', with: 'josh'
		fill_in 'Password', with: 'password'
    within registration_form[0] do 
      click_button('')
    end
    expect(page).to have_content "Email can't be blank"
	end

	scenario 'will return error if username is blank' do 
		visit '/users/new'
		registration_form = page.all('form#registration_form')
		fill_in 'Password', with: 'password'
		fill_in 'Email', with: 'bestemail@gmail.com'
    within registration_form[0] do 
      click_button('')
    end
    expect(page).to have_content "Username can't be blank"
	end

	scenario 'will return error if email is not unique' do 
		visit '/users/new'
		registration_form = page.all('form#registration_form')
		fill_in 'Password', with: 'password'
		fill_in 'Email', with: 'user@user.com'

    within registration_form[0] do 
      click_button('')
    end

    expect(page).to have_content "Email has already been taken"
	end

	scenario 'if valid credentials are filled in, it will send you to the user show page' do 
		visit '/users/new'
		registration_form = page.all('form#registration_form')
		fill_in 'Username', with: 'newuser'
		fill_in 'Password', with: 'password'
		fill_in 'Email', with: 'newuser@user.com'

    within registration_form[0] do 
      click_button('')
    end


    expect(page).to have_content "newuser"
	end
end