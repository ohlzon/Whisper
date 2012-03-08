class AddManufacturerToDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :manufacturer, :string
  end

  def self.down
    remove_column :devices, :manufacturer
  end
end
