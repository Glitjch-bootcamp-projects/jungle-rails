require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    context 'Passing all or none' do  
      it 'should save successfully if all validations, name, price, quantity, and category_id are present' do
          # @product = Product.new
          @category = Category.new
          
          @product = Product.create(:name => "gummies", :price_cents => 50000, :quantity => 29, :category => @category)
          expect(@product.valid?).to be true
      end
      it 'should NOT save successfully if one validation is missing from name, price, quantity, or category_id' do
        @product = Product.new
        @category = Category.new
        
        @category.name = nil
        @product.price_cents = nil
        @product.quantity = nil
        @product.category = nil
        expect(@product.valid?).to be false
      end
    end  

    context 'Passing single validations' do
      it 'should fail if the product name is missing' do
        @product = Product.new
        @category = Category.new

        @product.name = nil
        @product.price_cents = 50000 
        @product.quantity = 29
        @product.category = @category
        expect(@product.valid?).to be false
      end
      it 'should fail if the product price is missing' do
        @product = Product.new
        @category = Category.new

        @product.name = "gummies"
        @product.price_cents = nil
        @product.quantity = 29
        @product.category = @category
        expect(@product.valid?).to be false
      end
      it 'should fail if the product quantity is missing' do
        @product = Product.new
        @category = Category.new

        @product.name = "gummies"
        @product.price_cents = 50000
        @product.quantity = nil
        @product.category = @category
        expect(@product.valid?).to be false
      end
      it 'should fail if the product category is missing' do
        @product = Product.new
        @category = Category.new

        @product.name = "gummies"
        @product.price_cents = 50000
        @product.quantity = 29
        @product.category = nil
        expect(@product.valid?).to be false
      end 
    end

  end
end
