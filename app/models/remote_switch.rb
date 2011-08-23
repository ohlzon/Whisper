class RemoteSwitch < ActiveRecord::Base
  
  def initialize(unit_id)
    #Add verification of valid unit_id  
    @unit_id = unit_id
  end
  
  def on!
    # Quick and dirty output for verification...
    time = Time.now
    result = (`echo Switched on via a submethod in terminal at `)[0..-2] + " " + time.strftime("%H:%M:%S")
    p result    
  end
  
  def off!
    # Quick and dirty output for verification...
    time = Time.now
    result = (`echo Switched #{@unit_id} off via a submethod in terminal at `)[0..-2] + " " + time.strftime("%H:%M:%S")
    p result    
  end
  
  private
  
end
