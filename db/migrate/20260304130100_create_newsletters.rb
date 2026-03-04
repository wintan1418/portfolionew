class CreateNewsletters < ActiveRecord::Migration[8.0]
  def change
    create_table :newsletters do |t|
      t.string :subject, null: false
      t.text :body, null: false
      t.string :status, default: "draft"
      t.datetime :sent_at
      t.integer :recipients_count, default: 0
      t.timestamps
    end
  end
end
