class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :headline
      t.text :bio
      t.text :about
      t.string :email
      t.string :phone
      t.string :location
      t.string :github_url
      t.string :linkedin_url
      t.string :twitter_url
      t.string :website_url
      t.boolean :available_for_hire, default: true
      t.string :availability_text
      t.text :meta_description
      t.string :og_title
      t.text :og_description

      t.timestamps
    end
  end
end
