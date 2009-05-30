# == Schema Information
#
# Table name: products
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  description        :text
#  price              :decimal(, )
#  created_at         :datetime
#  updated_at         :datetime
#  category_id        :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#

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

  def self.find_all_price_between(min,max)
    Product.find(:all, :conditions => ["price between ? and ?", min, max])
  end

  def category_name
    category.try(:name)
  end

  # cria metodos para formatação de um atribudo em especifico
  # este processo pode ser feito para cada atributo do model

  # getter
  def formatted_price
    self.price.to_s.gsub(".", ",")
  end

  # setter
  def formatted_price=(value)
    self.price = value.gsub(",", ".").to_f
  end

end
