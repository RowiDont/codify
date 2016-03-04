class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :link, null: false
      t.string :description
      
      t.timestamps null: false
    end
  end
end
