class CreateCinemaHalls < ActiveRecord::Migration[6.1]
  def change
    create_table :cinema_halls do |t|
      t.string :name, null: false
      t.integer :row_number, null: false
      t.integer :row_total_seats, null: false
      t.timestamps
    end
  end
end
