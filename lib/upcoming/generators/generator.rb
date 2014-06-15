module Upcoming
  module Generator
    def next(from)
      date = from + 1
      date += 1 until valid?(date)
      date
    end
  end
end
