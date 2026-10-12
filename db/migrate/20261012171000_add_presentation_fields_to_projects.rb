class AddPresentationFieldsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :tagline, :string
    add_column :projects, :role, :string
    add_column :projects, :accent_color, :string
    add_column :projects, :highlights, :text, array: true, default: []
    add_column :projects, :group, :string
    add_index :projects, :group
  end
end
