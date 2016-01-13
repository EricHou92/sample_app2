class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.string :title
      t.integer :depreciation_rate
      t.float :price
      t.integer :style
      t.text :description
      t.string :picture_path
      t.string :picture_type
      t.boolean :commission
      t.boolean :delivery
      t.boolean :erasure
      t.integer :user_id
      t.integer :administrator_id

      t.timestamps null: false
    end
  end
end
