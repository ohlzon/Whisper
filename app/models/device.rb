class Device < ActiveRecord::Base
  def self.writeconfig
    configfile = File.open( "doc/tellstick.conf","w")
    configfile.write 'deviceNode = "/dev/tellstick"' + "\n"
    Device.all.each do |f|
      configfile.write 'device {' + "\n"
      configfile.write "  id = " + (f.id).to_s + "\n"
      configfile.write "  name = " + f.name + "\n"
      configfile.write "  model = " + f.model + "\n"
      configfile.write "  parameters {" + "\n"
      configfile.write "    house = " + (f.house).to_s + "\n"
      configfile.write "    unit = " + (f.unit).to_s + "\n"
      configfile.write "  }" + "\n"
      configfile.write "}" + "\n"
      configfile.write "\n"
    end
    configfile.close
  end
end
