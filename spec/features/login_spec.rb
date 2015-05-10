require 'rails_helper'

feature "User visits login page" do
  # before do
  #     allow_any_instance_of(Game).to receive(:computer_throw).and_return("scissors")
  # end
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
    expect(page).to have_content "Hello"
  end

end

# feature "User visits website" do
#   scenario "sees a list of games and can view them"

#   scenario "can start a new game"
# end