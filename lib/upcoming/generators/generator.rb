module Upcoming
  class Generator
    attr_reader :direction

    def initialize(options = {})
      @direction = options.fetch(:direction, :upcoming)
    end

    def step(from)
      date_range(from).find { |date| valid?(date) }
    end

    private

    def date_range(date)
      return date.downto(date.prev_year) if direction == :preceding
      date.upto(date.next_year)
    end
  end
end
