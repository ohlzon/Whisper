class RemoteSwitch < ActiveRecord::Base

  def on!
    result = (`echo Switched on in terminal at `)[0..-2] + " " + Time.zone.now.strftime("%H:%M:%S")
    p result
  end

  def off!
    unit = RemoteSwitch.find(params[:id])
    p unit
    result = (`echo Switched off in terminal at `)[0..-2] + " " + Time.zone.now.strftime("%H:%M:%S")
    p result
  end

  private

end
