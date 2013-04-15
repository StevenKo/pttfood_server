class Api::V1::ArticlesController < Api::ApiController

  def index
    category_id = params[:category_id]
    articles = Article.where("category_id = #{category_id}").show.select('id, author, title, release_time')
    render :json => articles
  end

  def show
    article = Article.find(params[:id])
    render :json => article
  end

  def search 
    articles = Article.search(params)
    
    # articles = Article.where("title like ?", "%#{search_str}%").order("id DESC").paginate(:page => params[:page], :per_page => 10)

    # page = params[:page]
    # @search = Article.show.search do
    #   fulltext search_str
    #   paginate(:page => page, :per_page => 10)
    #   # order_by :id, :desc
    # end
    # articles = @search.results
    render :json => articles
  end

  def new_articles
    articles = Article.is_not_from_cagetory.select("id, author, title, release_time, is_show").order("id DESC").paginate(:page => params[:page], :per_page => 20)
    articles = articles.select{|article| article if article.is_show}
    render :json => articles
  end
end
