class RemoteSwitchesController < ApplicationController
  before_filter :find_remote_switch, :only => [:show, :on, :off]
  private
  def find_remote_switch
    @remote_switch = RemoteSwitch.find(params[:id])
  end
  
  public
  def index
    @remote_switches = RemoteSwitch.all
  end

  def show
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
    @remote_switch.on!
    time = Time.now
    flash[:notice] = "Switched #{ @remote_switch.label } on at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :back, :notice => "Switched #{ @remote_switch.label } on at #{ Time.zone.now.strftime("%H:%M:%S") }"
  end
  
  def off
    @remote_switch.off!
    time = Time.now
    flash[:notice] = "Switched #{ @remote_switch.label } off at #{ Time.zone.now.strftime("%H:%M:%S") }"
    redirect_to :back, :notice => "Switched #{ @remote_switch.label } off at #{ Time.zone.now.strftime("%H:%M:%S") }"
  end

end
