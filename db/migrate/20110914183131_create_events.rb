class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :device
      t.boolean :mon
      t.boolean :tue
      t.boolean :wed
      t.boolean :thu
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun
      t.integer :hour
      t.integer :minute
      t.integer :state
      t.string  :crontask

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
