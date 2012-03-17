class Device < ActiveRecord::Base
  has_many :events
  def self.writeconfig
    # configfile = File.open( "doc/tellstick.conf","w") # Use this row for development purposes
    configfile = File.open( "/etc/tellstick.conf","w") # Use this row for production (remember to chown webuser/tellstick.conf)
    configfile.write 'deviceNode = "/dev/tellstick"' + "\n"
    Device.all.each do |f|
      configfile.write 'device {' + "\n"
      configfile.write '  id = "' + (f.id).to_s + '"' + "\n"
      configfile.write '  name = "' + f.name + '"' + "\n"
      configfile.write '  protocol = "' + f.protocol + '"' + "\n"
      configfile.write '  model = "' + f.model + '"' + "\n"
      configfile.write '  parameters {' + "\n"
      configfile.write '    house = "' + (f.house).to_s + '"' + "\n"
      configfile.write '    unit = "' + (f.unit).to_s + '"' + "\n"
      configfile.write '  }' + "\n"
      configfile.write '}' + "\n"
      configfile.write "\n"
    end
    configfile.close
  end
  
  def on!
    #p "Switched " + name.to_s + " on" # Used for development
    `tdtool -n #{id} 2>&1` # Used for production
    Device.find(id).update_attributes(:state => "on")
  end

  def off!
    #p "Switched " + name.to_s + " off" # Used for development
    `tdtool -f #{id} 2>&1` # Used for production
    Device.find(id).update_attributes(:state => "off")
  end

  def learn!
    result = (`echo Broadcasting learn signal for #{name} in terminal at `)[0..-2] + " " + Time.zone.now.strftime("%H:%M:%S")
    p result
    result = `tdtool --e #{id}`
    p result
  end
  
end
