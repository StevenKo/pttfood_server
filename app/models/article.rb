class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks


  belongs_to :category

  scope :is_from_cagetory, where('is_from_category = true')
  scope :is_not_from_cagetory, where('is_from_category = false')
  scope :show, where('is_show = true')

  def self.search(keyword)
    tire.search(load: true) do
      query { string keyword, default_operator: "AND" }
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :title
  end

  # define_index do
  #   indexes title
  #   indexes :id, sortable: true
  # end

  # searchable do 
  #   text :title
  #   integer :id
  # end
end
