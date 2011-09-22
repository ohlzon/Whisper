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
    #@event.cronalize
    if @event.save
      cronalize
      redirect_to(events_path, :notice => 'Schedule item saved')
    end
  end
  
  def update
    event = @event
    @event.save
  end
  
  def cronalize
    p "Cronalized through terminal via controller"
    cronfile = File.open( "doc/cronfile.txt","w")
    cronfile.truncate(0)
    @events = Event.all
    @events.each do |event|
      cronfile.write event.minute.to_s + " "
      cronfile.write event.hour.to_s + " "
      cronfile.write "* "
      cronfile.write "* "
      counter = 0
      event.scheduled_days.each do |day|
        counter = counter + 1
        cronfile.write day.to_s.slice!(0..2)
        cronfile.write "," unless counter == event.scheduled_days.count
      end
      cronfile.write " tdtool " + (event.on? ? "-n " : "-f ") + event.device.id.to_s
      cronfile.write "\n"      
    end
    cronfile.close
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to(events_path)
  end

end