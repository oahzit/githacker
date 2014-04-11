class CreateProfiles < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
      t.integer :user_id
      t.integer :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :name

      t.timestamps
  end
  end
end
