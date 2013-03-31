class AddIsShowToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :is_show, :boolean, :default => false
  end
end
