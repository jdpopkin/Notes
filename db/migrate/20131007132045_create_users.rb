class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :username
      t.string :session_token

      t.timestamps
    end

    add_index :users, :username
    add_index :users, :session_token
  end
end
