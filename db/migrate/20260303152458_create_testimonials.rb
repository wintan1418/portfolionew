class CreateTestimonials < ActiveRecord::Migration[8.0]
  def change
    create_table :testimonials do |t|
      t.string :author_name, null: false
      t.string :author_title
      t.string :company
      t.text :content, null: false
      t.integer :rating
      t.boolean :featured, default: false
      t.integer :position, default: 0
      t.string :relationship

      t.timestamps
    end
  end
end
