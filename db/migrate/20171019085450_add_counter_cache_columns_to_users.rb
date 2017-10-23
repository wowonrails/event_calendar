class AddCounterCacheColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :followed_users_count, :integer, default: 0

    User.reset_column_information
    User.find_each do |u|
      User.reset_counters u.id, :followers_count
      User.reset_counters u.id, :followed_users_count
    end
  end
end
