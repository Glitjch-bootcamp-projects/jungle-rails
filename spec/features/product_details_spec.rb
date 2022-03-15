require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

    scenario "They visit one product detail page" do
      # ACT

      visit root_path

      # uncomment to click on the fourth product's name
      # find("article.product:nth-child(4) h4").click
      
      # uncomment to click on the image of the first product
      # find("article.product:first-of-type img").click
      
      # uncomment to click the "details" button
      within("article.product:first-of-type") do
        find_link("Details").click
      end
      
      # VERIFY
      expect(page)
        .to have_content('Apparel', 'name', 'Description', 'Quantity', 'Price')
        have_css(".products-show .product-detail")
      
        # DEBUG 
      save_screenshot
      puts page.html 
    end


end
