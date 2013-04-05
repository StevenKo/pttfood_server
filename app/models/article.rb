class Article < ActiveRecord::Base
  belongs_to :category

  scope :is_from_cagetory, where('is_from_category = true')
  scope :is_not_from_cagetory, where('is_from_category = false')
  scope :show, where('is_show = true')

  # searchable do 
  #   text :title
  #   integer :id
  # end
end
