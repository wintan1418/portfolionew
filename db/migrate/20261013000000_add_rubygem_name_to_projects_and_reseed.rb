class AddRubygemNameToProjectsAndReseed < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :rubygem_name, :string unless column_exists?(:projects, :rubygem_name)
  end
end
