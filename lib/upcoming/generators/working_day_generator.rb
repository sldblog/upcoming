module Upcoming
  class WorkingDayGenerator
    WEEKDAYS = (1..5)

    def next(from)
      date = from + 1
      date += 1 until WEEKDAYS.include?(date.wday)
      date
    end
  end
end
