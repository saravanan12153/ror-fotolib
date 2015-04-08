class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.string :title, null: false
      t.text :details
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
