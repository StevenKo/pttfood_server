class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.string :release_time
      t.text :content
      t.string :link
      t.string :ptt_web_link
      t.integer :category_id
      t.boolean :is_from_category

      t.timestamps
    end

    add_index :articles, :category_id
  end
end
