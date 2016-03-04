class CreateCategoriesResources < ActiveRecord::Migration
  def change
    create_table :categories_resources do |t|
      t.integer :category_id, null: false
      t.integer :resource_id, null: false
    end
  end
end
