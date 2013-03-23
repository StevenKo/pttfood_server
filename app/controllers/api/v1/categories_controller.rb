class Api::V1::CategoriesController < Api::ApiController

  def index
    categories = Category.where("parent_id = 0").select_id_link_name
    render :json => categories
  end

  def area
    categories = Category.where("is_area = true").select_id_link_name
    render :json => categories
  end

  def subcagtegory
    c = Category.select('id').find(params[:id])
    categories = c.sub_categories.select_id_link_name
    render :json => categories
  end
end
