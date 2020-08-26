class CreateFacilities < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities do |t|
      t.integer :prefecture_id, null: false
      t.string :city,           null: false
      t.string :name,           null: false
      t.string :area,           null: false
      t.text :rule
      t.string :phone_number,   null: false
      t.string :price,          null: false
      t.references :user,       null: false, foreign_key: true
      t.timestamps
    end
  end
end
