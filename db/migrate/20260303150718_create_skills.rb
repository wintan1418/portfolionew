class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.string :name, null: false
      t.string :category
      t.integer :proficiency, default: 80
      t.string :icon
      t.integer :position, default: 0
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end
