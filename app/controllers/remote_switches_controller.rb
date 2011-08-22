class RemoteSwitchesController < ApplicationController
  def index
    @remote_switches = RemoteSwitch.all
  end

  def show
    @remote_switch = RemoteSwitch.find(params[:id])
  end

  def new
    @remote_switch = RemoteSwitch.new
  end

  def create
    @remote_switch= RemoteSwitch.new(params[:remote_switch])
    if @remote_switch.save
      redirect_to(@remote_switch, :notice => 'Remote switch saved')
    end
  end
  
  def on
    time = Time.now
    flash[:notice] = "Switched on at " + time.strftime("%H:%M:%S")
    redirect_to :action => "show"
  end
  
  def off
    time = Time.now
    flash[:notice] = "Switched off at " + time.strftime("%H:%M:%S")
    redirect_to :action => "show"
  end
end
