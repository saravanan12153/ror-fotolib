class AddSlugsToPics < ActiveRecord::Migration
  def change
    add_column :pics, :slug, :string
    add_index :pics, :slug, unique: true
  end
end
