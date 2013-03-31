class Api::V1::ArticlesController < Api::ApiController

  def index
    category_id = params[:category_id]
    articles = Article.where("category_id = #{category_id}").select('id, author, title, release_time')
    render :json => articles
  end

  def show
    article = Article.find(params[:id])
    render :json => article
  end

  def search 
    search_str = params[:keyword]
    page = params[:page]
    @search = Article.search do
      fulltext search_str
      paginate(:page => page, :per_page => 10)
    end
    articles = @search.results
    render :json => articles
  end

  def new_articles
    articles = Article.is_not_from_cagetory.select("id, author, title, release_time").order("id DESC").paginate(:page => params[:page], :per_page => 20)
    render :json => articles
  end
end
