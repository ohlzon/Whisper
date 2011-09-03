class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :name
      t.string :protocol
      t.string :model
      t.integer :house
      t.integer :unit
      t.string :location
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
