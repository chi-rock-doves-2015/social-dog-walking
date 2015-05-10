require 'rails_helper'

user_show_page_message = "Hello"

feature "login functionality" do
 let!(:user) {User.create!(username: "user", email: 'user@user.com', password: 'password')}

  scenario "upon page load user sees login header" do
    visit '/login'
    expect(page).to have_content "Log in"
  end



  scenario "empy fields will return an error" do 
    visit '/login'
    login_form = page.all('form#login_form')
    within login_form[0] do 
      click_button('')
    end
    expect(page).to have_content "Invalid email or password"
  end

  scenario "can login with valid email and password" do 
    visit '/login'
    login_form = page.all('form#login_form')
    fill_in 'Password', with: 'password'
    fill_in 'Email', with: 'user@user.com'
    within login_form[0] do 
      click_button('')
    end
    expect(page).to have_content user_show_page_message
  end
end
