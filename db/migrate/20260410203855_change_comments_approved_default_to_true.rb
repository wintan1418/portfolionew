class ChangeCommentsApprovedDefaultToTrue < ActiveRecord::Migration[8.0]
  def change
    change_column_default :comments, :approved, from: false, to: true
  end
end
