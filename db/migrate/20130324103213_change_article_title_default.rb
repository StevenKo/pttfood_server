class ChangeArticleTitleDefault < ActiveRecord::Migration
  def change
    change_column :articles, :title, :string, :default => ""
  end
end
