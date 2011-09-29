class Event < ActiveRecord::Base
  belongs_to :device
  before_save { self.calc_next_run }
  
  def time
    "%.2d:%.2d" % [hour, minute]
  end
  
  def on?
    state == 1
  end
  
  def scheduled_days
    [
      ("Monday"    if mon?),
      ("Tuesday"   if tue?),
      ("Wednesday" if wed?),
      ("Thursday"  if thu?),
      ("Friday"    if fri?),
      ("Saturday"  if sat?),
      ("Sunday"    if sun?)
    ].compact
  end
  
  def self.due_for_running
    where('next_run_at < ?', Time.zone.now) ## Production
    #where('next_run_at > ?', Time.zone.now) ## Development
  end
  
  # TODO run! runs calc_next_run_at two times, one time for the callback and one time manually. Can we optimize that? (Gnäll på lowe)
  def run!
    puts "Switching " + device.name + " " + on?.to_s + " " + "at " + hour.to_s + ":" + minute.to_s + " on " + Time.zone.now.to_s
    if on?
      device.on!
    else
      device.off!
    end
    sleep 2
    self.next_run_at = self.calc_next_run
  end
  
  def calc_next_run
    date = Time.zone.now.midnight
    self.next_run_at = nil
    until self.next_run_at
      date += 1.day
      self.next_run_at = date.change(:hour => self.hour, :min => self.minute) if date_is_run_day?(date)
    end
  end

  private
  def date_is_run_day?(date)
    return true if date.monday? && self.mon?
    return true if date.tuesday? && self.tue?
    return true if date.wednesday? && self.wed?
    return true if date.thursday? && self.thu?
    return true if date.friday? && self.fri?
    return true if date.saturday? && self.sat?
    return true if date.sunday? && self.sun?

    return false
  end
  
end
