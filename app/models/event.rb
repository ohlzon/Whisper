class Event < ActiveRecord::Base
  belongs_to :device
  before_save { self.calc_next_run! }
  
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
  end
  
  # TODO run! runs calc_next_run_at two times, one time for the callback and one time manually. Can we optimize that? (Gnäll på lowe)
  def run!
    puts "Switching " + device.id.to_s + " " + on?.to_s + " " + "at " + hour.to_s + ":" + minute.to_s + " on " + Time.zone.now.to_s
    if on?
      device.on!
    else
      device.off!
    end
    sleep 2
    self.calc_next_run!
    self.save!
  end
  
  def calc_next_run!
    t = Time.zone.now.change(:hour => self.hour, :min => self.minute)
    self.next_run_at = nil
    until self.next_run_at
      self.next_run_at = t if is_run_time?(t)
      t += 1.day
    end
  end

  private
  def is_run_time?(time)
    unless time.past?
      return true  if time.monday? && self.mon?
      return true  if time.tuesday? && self.tue?
      return true  if time.wednesday? && self.wed?
      return true  if time.thursday? && self.thu?
      return true  if time.friday? && self.fri?
      return true  if time.saturday? && self.sat?
      return true  if time.sunday? && self.sun?
    end

    return false
  end
  
end
