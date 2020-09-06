class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name,          null: false
      t.string :activity,      null: false
      t.string :image,         null: false
      t.string :twitter_url
      t.string :facebook_url
      t.string :instagram_url
      t.text :content,         null: false
      t.timestamps
    end
  end
end
