class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: ':::Please supply a GIF, JPG or PNG Image URL'
  }
  validates :title, length: {
    minimum: 10,
    message: ':::Title should be 10 or more characters long'
  }
end
