class RenameRowToRowNumberInCinemaHalls < ActiveRecord::Migration[6.0]
  def change
    remove_column :cinema_halls, :row, :string
    add_column :cinema_halls, :row_number, :integer, null: false
  end
end
