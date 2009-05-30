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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
