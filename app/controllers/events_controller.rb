class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  
  def new
    @event = Event.new
    @devices = Device.find(:all).map {|d| [d.name,d.id]}
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      Event.calc_next_run!
      redirect_to(events_path, :notice => 'Schedule item saved')
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