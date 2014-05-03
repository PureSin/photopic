class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :facebookID
      t.string :facebookAccessToken
      t.string :email
      t.string :location

      t.timestamps
    end
  end
end
