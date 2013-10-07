class AddUserIds < ActiveRecord::Migration
  def up
    add_column :artists, :user_id, :integer
    add_column :albums, :user_id, :integer
    add_column :songs, :user_id, :integer
  end

  def down
    remove_column :artists, :user_id
    remove_column :albums, :user_id
    remove_column :songs, :user_id
  end
end
