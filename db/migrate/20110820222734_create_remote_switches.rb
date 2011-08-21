class CreateRemoteSwitches < ActiveRecord::Migration
  def self.up
    create_table :remote_switches do |t|
      t.string :label
      t.string :location
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :remote_switches
  end
end
