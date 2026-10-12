class RenameGroupToFamilyOnProjects < ActiveRecord::Migration[8.1]
  def change
    rename_column :projects, :group, :family
  end
end
