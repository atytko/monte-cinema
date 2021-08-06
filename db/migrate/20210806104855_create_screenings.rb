class CreateScreenings < ActiveRecord::Migration[6.1]
  def change
    create_table :screenings do |t|
      t.datetime :screening_time, null: false
      t.references :cinema_hall, null: false
      t.references :movie, null: false
      t.timestamps
    end
  end
end
