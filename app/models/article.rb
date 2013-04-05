class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks


  belongs_to :category

  scope :is_from_cagetory, where('is_from_category = true')
  scope :is_not_from_cagetory, where('is_from_category = false')
  scope :show, where('is_show = true')

  def self.search(params)

    tire.search(page: params[:page], per_page: 20, load: true) do
      query { string params[:keyword], default_operator: "AND" }
      sort{by :id, 'desc'}
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :title, :analyzer => "cjk"
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
