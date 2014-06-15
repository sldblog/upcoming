module Upcoming
  class WorkingDayGenerator
    include Generator

    WEEKDAYS = (1..5)

    def valid?(date)
      WEEKDAYS.include? date.wday
    end
  end
end
