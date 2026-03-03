class CreateExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :experiences do |t|
      t.string :company, null: false
      t.string :role, null: false
      t.text :description
      t.string :location
      t.string :company_url
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :current, default: false
      t.string :employment_type
      t.text :highlights, array: true, default: []
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
