class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :use_application, null: false
      t.time :start_time,        null: false
      t.time :end_time,          null: false
      t.boolean :release,        null: false, default: false
      t.references :facility,    null: false, foreign_key: true
      t.references :user,        null: false, foreign_key: true
      # t.references :team,        foreign_key: true
      t.timestamps
    end
  end
end
