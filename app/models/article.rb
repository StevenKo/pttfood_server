class Article < ActiveRecord::Base
  belongs_to :category

  searchable do 
    text :title
  end
end
