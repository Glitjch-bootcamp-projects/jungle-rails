require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
   #SETUP
   before :each do
    @category = Category.create! name: "Apparel"
    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraphs(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "updates cart counter on navbar" do
    # ACT

    visit root_path
    
    within('nav') do
      expect(page).to have_content('My Cart (0)')
    end
    within('article.product:nth-child(3)') do
      click_button "Add"
    end
    within('nav') do
      expect(page).to have_content('My Cart (1)')
    end
    within('article.product:nth-child(5)') do
      click_button "Add"
    end
    within('nav') do
      expect(page).to have_content('My Cart (2)')
      expect(page).not_to have_content('My Cart (3)')
    end
    
    # DEBUG
    save_screenshot
    puts page.html 

  end


end

# home_page feature because you need the category and its products on the home page. Your test scenario should visit the home page and click 'Add to Cart' buttons for one of the products.

# To test for the Cart being updated, you should keep it simple and check the text rendered in the top nav (by the _top_nav.html.erb partial) changes from "My Cart (0)" to to "My Cart (1)
