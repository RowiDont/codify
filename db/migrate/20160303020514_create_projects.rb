class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :projects, [:title, :user_id], unique: true
  end
end
