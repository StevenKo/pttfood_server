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

  def regenerate_ptt_blog_link
     if /((http|https):\/\/([a-zA-Z0-9\.\/\&\_\=\-]*))/ =~ self.content
        if is_blog_link($1)
          self.link = $1 
          save
        end
     end
  end

  private

  def is_blog_link(link)
    return true if link.index("blog")
    return true if link.index("ipeen.com.tw")
    return false
  end
end
