class Event < ActiveRecord::Base
  belongs_to :device
  
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
  
  def cronalize
    p "Cronalizing in terminal, via model"
    self.crontask = "hjbk"
  end
  
end
