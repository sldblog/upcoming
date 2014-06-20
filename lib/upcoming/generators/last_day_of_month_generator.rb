module Upcoming
  class LastDayOfMonthGenerator < Generator
    def valid?(date)
      (date + 1).month != date.month
    end
  end
end
