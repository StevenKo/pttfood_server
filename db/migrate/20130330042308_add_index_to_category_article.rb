class AddIndexToCategoryArticle < ActiveRecord::Migration
  def change
    add_index :articles, :ptt_web_link 
  end
end
