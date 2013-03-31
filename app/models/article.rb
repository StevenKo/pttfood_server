class Article < ActiveRecord::Base
  belongs_to :category

  scope :is_from_cagetory, where('is_from_category = true')
  scope :is_not_from_cagetory, where('is_from_category = false')

  searchable do 
    text :title
  end
end
