class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :author_name, null: false
      t.string :author_email
      t.text :body, null: false
      t.references :post, null: false, foreign_key: true
      t.references :parent, foreign_key: { to_table: :comments }
      t.boolean :approved, default: false, null: false

      t.timestamps
    end

    add_index :comments, [:post_id, :approved]
  end
end
