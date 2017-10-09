class AddDurationToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :duration, :float
  end
end
