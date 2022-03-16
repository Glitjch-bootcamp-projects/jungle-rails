require 'rails_helper'

RSpec.feature "UserLogouts", type: :feature, js: true do
  before :each do
    @user = User.create!(
     :first_name => "bob",
     :last_name => "ross",
     :email => "bobross@gmail.com",
     :password => "hello",
     :password_confirmation => "hello"
    )
   end

  scenario "user can log out successfully" do
    visit root_path

    within('nav') do
      click_on 'Login'
    end

    expect(page)
      .to have_content('Email', 'Password')
      have_css('input#email')
      
      fill_in "email", with: "bobross@gmail.com"
      fill_in "password", with: "hello"
      click_button "Submit"

      expect(page).to have_content("Signed in as", "logout")
      expect(page).to have_content(@user.first_name, @user.last_name)

    
      within('nav') do
        click_on 'Logout'
      end
    
      expect(page).not_to have_content("Signed in as", "logout")
      expect(page).not_to have_content(@user.first_name, @user.last_name)
      
      save_screenshot
    puts page.html
  end
end
