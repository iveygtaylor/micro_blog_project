class CreateUsers < ActiveRecord::Migration[5.0]
 #Old Way to set up both
 # def up
  # create_table :users do |t|
 #    t.string :name
  # end
 #end
 #def down
  # drop_table :users
 #end




 #New Way ... Change rolls back automatically
  def change
    create_table :users do |t|
      t.string :first_name, default: ''
      t.string :last_name, default: ''
      t.string :email, default: ''
      t.string :password, default: ''
      t.datetime :birthday, default: ''
      t.string :phone, default: ''

      t.timestamps
    end
  end
end


