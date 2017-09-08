class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :status
      t.datetime :startdate
      t.datetime :endate
      t.integer :numberofguests
      t.string :needcaptain

      t.timestamps
    end
  end
end
