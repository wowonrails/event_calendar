class AddConstraintToExistingColumns < ActiveRecord::Migration[5.1]
  def change
    change_column_null :events, :title, false
    change_column_null :events, :description, false
    change_column_null :events, :periodicity, false
    change_column_null :events, :start, false
    change_column_null :events, :user_id, false

    change_column_null :relationships, :follower_id, false
    change_column_null :relationships, :followed_id, false
  end
end
