class AddTokenAndStatusToTestimonials < ActiveRecord::Migration[8.0]
  def change
    add_column :testimonials, :token, :string
    add_column :testimonials, :status, :string, default: "approved"
    add_column :testimonials, :submitted_at, :datetime
    add_index :testimonials, :token, unique: true
  end
end
