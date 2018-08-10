module Upcoming
  class WorkingDayGenerator < Generator
    WEEKDAYS = (1..5)

    def initialize(options = {})
      super(options)
      @holidays = options.fetch(:holidays, []).map { |date|
        date.is_a?(String) ? Date.parse(date) : date
      }
    end

    def valid?(date)
      return false if holidays.include?(date)
      WEEKDAYS.include?(date.wday)
    end

    private

    attr_reader :holidays
  end
end
