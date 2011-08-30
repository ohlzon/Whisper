class DevicesController < ApplicationController
  before_filter :find_device, :only => [:show, :on, :off, :writeconfig]
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
  end
  
  def off
  end
  
  def writeconfig
    @device.writeconfig
  end
end