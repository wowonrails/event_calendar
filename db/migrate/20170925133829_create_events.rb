class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :periodicity
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
