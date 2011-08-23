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
    RemoteSwitch.new(params[:id]).on!
    time = Time.now
    flash[:notice] = "Switched " + RemoteSwitch.find(params[:id]).label + " on at " + time.strftime("%H:%M:%S")
    redirect_to :back
  end
  
  def off
    RemoteSwitch.new(params[:id]).off!
    time = Time.now
    flash[:notice] = "Switched " + RemoteSwitch.find(params[:id]).label + " off at " + time.strftime("%H:%M:%S")
    redirect_to :back
  end

end
