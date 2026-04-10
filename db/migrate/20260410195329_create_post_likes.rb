class CreatePostLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :post_likes do |t|
      t.references :post, null: false, foreign_key: true
      t.string :session_id, null: false

      t.timestamps
    end

    add_index :post_likes, [:post_id, :session_id], unique: true
  end
end
