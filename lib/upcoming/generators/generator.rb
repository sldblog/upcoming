require 'active_support/core_ext/string'

module Upcoming
  class Generator

    attr_reader :choose

    def initialize(options = {})
      @choose = options.fetch(:choose, :first)
    end

    def step(from)
      date_range(from).find { |date| valid?(date) }
    end

    private

    def date_range(date)
      return date.downto(date.prev_year) if choose == :latest
      date.upto(date.next_year)
    end

  end
end
