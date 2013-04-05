class AddIndexToArticle < ActiveRecord::Migration
  def change
    add_index :articles, :is_show
    add_index :articles, :is_from_category
  end
end
