# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :duration, null: false
      t.string :genre, null: false
      t.string :director, null: false
      t.timestamps
    end
  end
end
