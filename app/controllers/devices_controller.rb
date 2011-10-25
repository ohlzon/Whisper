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
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
    @devicetypes = Devicetype::DEVICE_TYPES
    @protocols = Protocol::PROTOCOLS
    takenhousenumbers = Device.all.map(&:house)
    until @housenumber and not takenhousenumbers.include?(@housenumber)
        @housenumber = rand(67000000)
    end
    @unitnumber = 1+rand(16)
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