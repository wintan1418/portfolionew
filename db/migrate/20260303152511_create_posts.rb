class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :excerpt
      t.string :status, default: "draft"
      t.datetime :published_at
      t.boolean :featured, default: false
      t.integer :reading_time
      t.string :meta_title
      t.text :meta_description
      t.string :og_title
      t.text :og_description
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, [:status, :published_at]
  end
end
