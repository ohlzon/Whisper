class DevicesController < ApplicationController
  before_filter :find_device, :only => [:show, :on, :off, :learn]
  private
  def find_device
    @device = Device.find(params[:id])
  end

  public
  
  def index
    @devices = Device.all
  end

  def show    
  end

  def new
    @device = Device.new
  end
  
  def destroy
    @device = Device.destroy(params[:id])
    redirect_to :action => 'index'
  end

  def create
    @device= Device.new(params[:device])
    if @device.save
      redirect_to(@device, :notice => 'Device saved')
    end
  end
  
  def on
    @device.on!
    time = Time.now
    flash[:notice] = "Switched #{ @device.name } on at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :back, :notice => "Switched #{ @device.name } on at #{ Time.zone.now.strftime("%H:%M:%S") }"
  end
  
  def off
    @result = @device.off!
    time = Time.now
    flash[:notice] = "Switched #{ @device.name } off at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :back, :notice => "Switched #{ @device.name } off at #{ Time.zone.now.strftime("%H:%M:%S") } with result #{@result}"
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