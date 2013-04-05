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
    # search_str = params[:keyword]
    # page = params[:page]
    # @search = Article.show.search do
    #   fulltext search_str
    #   paginate(:page => page, :per_page => 10)
    #   order_by :id, :desc
    # end
    # articles = @search.results
    render :json => "articles"
  end

  def new_articles
    articles = Article.show.is_not_from_cagetory.select("id, author, title, release_time").order("id DESC").paginate(:page => params[:page], :per_page => 20)
    render :json => articles
  end
end
