module Upcoming
  def self.for(config = {})
    Upcoming::Factory.new(config)
  end
end
