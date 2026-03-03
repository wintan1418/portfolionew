class CreateSocialLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :social_links do |t|
      t.string :platform, null: false
      t.string :url, null: false
      t.string :icon
      t.integer :position, default: 0
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
