class DevicesController < ApplicationController
  before_filter :find_device, :only => [:show, :update, :on, :off, :learn]
  private
  def find_device
    @device = Device.find(params[:id])
  end

  public
  
  def index
    @devices = Device.all
    @days = ""
    @devices.each do |device|
      device.events.any? do |event|
        @days = @days + event.device.name + "Yaa"
      end
    end
  end

  def show    
  end
  
  def edit
    @devicetypes = Devicetype::DEVICE_TYPES
    @protocols = Protocol::PROTOCOLS
    @manufacturers = Manufacturer::MANUFACTURERS
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
    @devicetypes = Devicetype::DEVICE_TYPES
    @protocols = Protocol::PROTOCOLS
    @manufacturers = Manufacturer::MANUFACTURERS
  end
  
  def update
    if @device.update_attributes(params[:device])
      redirect_to(devices_path, :notice => 'Changes saved' )
    end
  end
  
  def destroy
    @device = Device.find(params[:id])
    if @device.events.any?
      redirect_to(devices_path, :notice => 'There are schedules assigned to the device youre trying to delete.' )
    else
      @device = Device.destroy(params[:id])
      redirect_to :action => 'index', :notice => 'Done!'
    end
  end

  def create    
    @device = Device.new(params[:device])
    existingdevices = Device.all
    supported_housenumbers = ["266","258","426","430","434","438","442","446","450","454","458"]
    
    until @housenumber and @unitnumber
      @housenumber = supported_housenumbers[rand(11)]
      @unitnumber = 1+rand(15)
      existingdevices.each do |exdev|
        puts "Checking #{@housenumber} and #{@unitnumber} against #{exdev.house} and #{exdev.unit}"
        if exdev.house == @housenumber.to_i and exdev.unit == @unitnumber.to_i
          puts "Combination found, reseting to nil"
          @housenumber = nil
          @unitnumber = nil
        end
      end
    end
    
    @device.house = @housenumber
    @device.unit = @unitnumber

    if @device.save
      Device.writeconfig
      redirect_to(devices_path, :notice => 'Device saved')
    end
  end

  def on
    result = @device.on!
    time = Time.now
    #flash[:notice] = "Switched #{ @device.name } on at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :devices, :notice => "Switched #{ @device.name } on at #{ Time.zone.now.strftime("%H:%M:%S") } with result #{result}"
  end
  
  def off
    result = @device.off!
    time = Time.now
    #flash[:notice] = "Switched #{ @device.name } off at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :devices, :notice => "Switched #{ @device.name } off at #{ Time.zone.now.strftime("%H:%M:%S") } with result #{result}"
  end
  
  def writeconfig
    Device.writeconfig
    redirect_to(devices_path)
  end
  
  def learn
    @device.learn!
    redirect_to(devices_path)
  end
  
end