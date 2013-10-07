class CreateSongComments < ActiveRecord::Migration
  def change
    create_table :song_comments do |t|
      t.integer :song_id
      t.integer :author_id
      t.text :body
      t.integer :parent_comment_id

      t.timestamps
    end

    add_column :song_comments, :song_id
    add_column :song_comments, :author_id
    add_column :song_comments, :parent_comment_id
  end
end
