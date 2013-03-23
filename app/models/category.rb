class Category < ActiveRecord::Base
  has_many :sub_categories, :foreign_key => 'parent_id', :class_name => 'Category'
  has_many :articles

  scope :select_id_link_name, select('id, link, name')

end
