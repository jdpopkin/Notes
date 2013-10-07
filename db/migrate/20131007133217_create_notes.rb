class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :song_id
      t.integer :author_id
      t.text :body
      t.integer :start_index
      t.integer :end_index

      t.timestamps
    end

    add_index :notes, :song_id
    add_index :notes, :author_id
  end
end
