class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject
      t.text :message, null: false
      t.string :status, default: "unread"
      t.string :phone
      t.string :company
      t.string :budget_range

      t.timestamps
    end
  end
end
