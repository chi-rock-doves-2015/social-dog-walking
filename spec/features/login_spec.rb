require 'rails_helper'

feature "User visits login page" do
  # before do
  #     allow_any_instance_of(Game).to receive(:computer_throw).and_return("scissors")
  # end
  scenario "upon page load user sees login header" do
    visit '/login'
    expect(page).to have_content "Log in"
  end

  scenario "empy fields will return an error" do 
    visit '/login'
    click_button('')
    expect(page).to have_content "Invalid email or password"
  end

end

# feature "User visits website" do
#   scenario "sees a list of games and can view them"

#   scenario "can start a new game"
# end