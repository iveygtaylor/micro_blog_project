class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :occupants
      t.string :name, default: ''
      t.integer :user_id
      t.datetime :movein
      t.string :primary_contact, default: ''

      t.timestamps
    end
  end
end
