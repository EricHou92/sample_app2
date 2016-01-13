class CreateCollects < ActiveRecord::Migration
  def change
    create_table :collects do |t|
      t.integer :user_id
      t.integer :thing_id

      t.timestamps null: false
    end
  end
end
