class SettingsController < ApplicationController
  def index
    @devices = Device.all    
  end
end