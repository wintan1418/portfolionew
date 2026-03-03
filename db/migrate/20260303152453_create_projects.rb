class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary
      t.string :live_url
      t.string :github_url
      t.text :tech_stack, array: true, default: []
      t.boolean :featured, default: false
      t.integer :position, default: 0
      t.date :completed_on
      t.string :status, default: "completed"
      t.string :project_type, default: "personal"

      t.timestamps
    end

    add_index :projects, :slug, unique: true
  end
end
