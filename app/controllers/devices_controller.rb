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

    takenhousenumbers = Device.all.map(&:house)
    takenunitnumbers = Device.all.map(&:unit)

    if @device.manufacturer == "proove"
      supported_housenumbers = ["266","258","426","430","434","438","442","446","450","454","458"]
      @housenumber = supported_housenumbers[rand(10)]
      until @unitnumber and not takenunitnumbers.include?(@unitnumber)
          @unitnumber = 1+rand(16)
      end
      Device.all.each do |existing_device|
        if @housenumber == existing_device.house and @unitnumber == existing_device.unit
          @housenumber = supported_housenumbers[rand(10)]
          until @unitnumber and not takenunitnumbers.include?(@unitnumber)
              @unitnumber = 1+rand(16)
          end
        end
        ### Detta skapar bara ett nytt nummer utan att kolla om det redan existerar en kombination. Den borde börja om utvärderingen när den skapar nya nummer.
      end
    else
      #until @housenumber and not takenhousenumbers.include?(@housenumber) and @unitnumber and not takenunitnumbers.include?(@unitnumber)
      until @housenumber and @unitnumber and not takenhousenumbers.include?(@housenumber) and not takenunitnumbers.include?(@unitnumber)
          @housenumber = rand(67000000)
          @unitnumber = 1+rand(151)
          Array(1..16).all? { |n| takenunitnumbers.include?(n) }
          #### Fixa så den skapar ett nytt husnummer om alla 16 enheter är upptagna på nuvarande hus
          ### Kanske bygga så den fyller hus för hus istället?
          ### Börjar på ett visst hus, fyller det, sedan går den över på nästa hus
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