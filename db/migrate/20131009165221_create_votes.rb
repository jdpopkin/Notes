class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.integer :user_id
      t.references :votable, polymorphic: true
      t.timestamps
    end

    add_index :votes, :user_id
  end
end
