class CreateProjectResources < ActiveRecord::Migration
  def change
    create_table :projects_resources do |t|
      t.integer :project_id, null: false
      t.integer :resource_id, null: false
      
      t.timestamps null: false
    end
  end
end
