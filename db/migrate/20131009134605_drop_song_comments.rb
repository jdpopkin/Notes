class DropSongComments < ActiveRecord::Migration
  def up
    drop_table :song_comments
  end

  def down
    create_table :song_comments do |t|
      t.integer :song_id
      t.integer :author_id
      t.text :body
      t.integer :parent_comment_id

      t.timestamps
    end

    add_index :song_comments, :song_id
    add_index :song_comments, :author_id
    add_index :song_comments, :parent_comment_id
  end
end
