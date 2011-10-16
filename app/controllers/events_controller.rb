class EventsController < ApplicationController
  before_filter :only => [:new, :create] do
    @devices = Device.find(:all).map {|d| [d.name,d.id]}
  end
  
  def index
    @events = Event.all
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to(events_path, :notice => 'Schedule item saved')
    else
      flash.now[:notice] = @event.errors.full_messages.join(", ")
      render :new
    end
  end
  
  def update
    event = @event
    @event.save
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to(events_path)
  end

end