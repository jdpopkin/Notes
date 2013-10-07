class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.text :lyrics, null: false
      t.integer :album
      t.integer :artist

      t.timestamps
    end

    add_index :songs, :album
    add_index :songs, :artist
  end
end
