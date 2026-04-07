class AddContentMarkdownToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :content_markdown, :text
  end
end
