class Product < ActiveRecord::Base
 
  has_attached_file :photo, :styles => { :thumb => "80x80#" }, :default_url => "/images/image_null.jpg"

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 50
  validates_presence_of :price
  validates_numericality_of :price
 
  belongs_to :category

  # se o metodo for chamado pela classe, usar o self
  def self.for_showcase
    Product.all
  end

  def category_name
    category.try(:name)
  end

end
