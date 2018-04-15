class Stock < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.decimal :last_price
      t.timestamps
    end
  end
end