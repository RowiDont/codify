class CreateCategoriesProjects < ActiveRecord::Migration
  def change
    create_table :categories_projects do |t|
      t.integer :category_id, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end
  end
end
