module Upcoming
  class WorkingDayGenerator < Generator
    WEEKDAYS = (1..5)

    def valid?(date)
      WEEKDAYS.include? date.wday
    end
  end
end
