class CreateResourcesUsers < ActiveRecord::Migration
  def change
    create_table :resources_users do |t|
      t.integer :user_id, null: false
      t.integer :resource_id, null: false

      t.timestamps null: false
    end

    add_column :categories_resources, :created_at, :datetime
    add_column :categories_resources, :updated_at, :datetime
  end
end
