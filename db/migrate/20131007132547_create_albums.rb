class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :artist_id

      t.timestamps
    end

    add_column :albums, :artist_id
  end
end
