class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rating
      t.string :content
      t.integer :user_id
      t.integer :thing_id

      t.timestamps null: false
    end
  end
end
