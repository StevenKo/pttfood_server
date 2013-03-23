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
end
