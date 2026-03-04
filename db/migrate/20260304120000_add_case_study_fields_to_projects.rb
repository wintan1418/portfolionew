class AddCaseStudyFieldsToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :challenge, :text
    add_column :projects, :solution, :text
    add_column :projects, :results, :text
    add_column :projects, :client_name, :string
    add_column :projects, :client_role, :string
    add_column :projects, :metrics, :text
  end
end
