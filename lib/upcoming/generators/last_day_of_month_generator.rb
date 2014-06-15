module Upcoming
  class LastDayOfMonthGenerator
    include Generator

    def valid?(date)
      (date + 1).month != date.month
    end
  end
end
