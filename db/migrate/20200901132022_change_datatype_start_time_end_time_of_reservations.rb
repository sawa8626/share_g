class ChangeDatatypeStartTimeEndTimeOfReservations < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :start_time, :datetime, null: false
    change_column :reservations, :end_time, :datetime, null: false
  end
end
