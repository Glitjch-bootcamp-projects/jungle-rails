require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    context 'Passing all or none' do  
      it 'should save successfully if all validations, name, price, quantity, and category_id are present' do
          # @product = Product.new
          @category = Category.new
          
          @product = Product.create(:name => "gummies", :price => 50000, :quantity => 29, :category => @category )
          puts @product.errors
          puts @product.valid?
          expect(@product.valid?).to be true
      end
      it 'should NOT save successfully if one validation is missing from name, price, quantity, or category_id' do
        @product = Product.new
        @category = Category.new
        
        @category.name =
        @product.price = 
        @product.quantity = 
        @product.category_id = @category.id
        expect(@product.valid?).to be false
      end
    end  

    context 'Passing single validations' do
      it 'should fail if the product name is missing' do
        @product = Product.new
        @category = Category.new

        @category.name =
        @product.price = 50000 
        @product.quantity = 29
        @product.category_id = @category.id
        expect(@product.valid?).to be false
      end
      it 'should fail if the product price is missing' do
        @product = Product.new
        @category = Category.new

        @category.name = "gummies"
        @product.price = 
        @product.quantity = 29
        @product.category_id = @category.id
        expect(@product.valid?).to be false
      end
      it 'should fail if the product quantity is missing' do
        @product = Product.new
        @category = Category.new

        @category.name = "gummies"
        @product.price = 50000
        @product.quantity = 
        @product.category_id = @category.id
        expect(@product.valid?).to be false
      end
      it 'should fail if the product category is missing' do
        @product = Product.new
        @category = Category.new

        @category.name = "gummies"
        @product.price = 50000
        @product.quantity = 29
        @product.category_id =
        expect(@product.valid?).to be false
      end
    
    end


  end
end
