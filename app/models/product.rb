class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price_cents, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sold_out?
    if self.quantity == 0  
      true
    end
  end

end
