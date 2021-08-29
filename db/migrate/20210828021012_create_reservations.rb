class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.string :code, null: false, index: { unique: true }
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :status
      t.monetize :payout_price
      t.monetize :security_price
      t.monetize :total_price
      t.references :guest

      t.timestamps
    end
  end
end
