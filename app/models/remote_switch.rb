class RemoteSwitch < ActiveRecord::Base

  def on!
    result = (`echo Switched on #{label} in terminal at `)[0..-2] + " " + Time.zone.now.strftime("%H:%M:%S")
    p result
  end

  def off!
    result = (`echo Switched off #{label} in terminal at `)[0..-2] + " " + Time.zone.now.strftime("%H:%M:%S")
    p result
  end

  private

end
