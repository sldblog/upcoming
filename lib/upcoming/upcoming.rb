module Upcoming
  def self.every(name, options = {})
    Upcoming::Factory.new(options.merge(every: name))
  end
end
