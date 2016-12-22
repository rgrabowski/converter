class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.date :date, unique: true
      t.decimal :rate, precision: 5, scale: 4

      t.timestamps
    end
    add_index :exchange_rates, :date
  end
end