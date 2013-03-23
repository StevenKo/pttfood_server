class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.string :link
      t.boolean :is_area
      t.timestamps
    end
    add_index :categories, :parent_id
    add_index :categories, :link
    add_index :categories, :is_area
  end
end
