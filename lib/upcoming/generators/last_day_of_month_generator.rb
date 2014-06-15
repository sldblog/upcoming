module Upcoming
  class LastDayOfMonthGenerator
    def next(from)
      date = from + 1
      date += 1 until (date + 1).month != date.month
      date
    end
  end
end
