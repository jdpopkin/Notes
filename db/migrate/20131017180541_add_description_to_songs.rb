class AddDescriptionToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :description, :text
  end
end
