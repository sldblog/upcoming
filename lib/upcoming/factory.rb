require 'date'
require 'active_support/core_ext/string'

module Upcoming
  class Factory
    include Enumerable

    def initialize(options = {})
      @options = parse(options)
      @chain = []
    end

    def self.every(method, options = {})
      new(options).then_find_first(method)
    end

    def then_find_first(method)
      @chain << create_generator(method, :first)
      self
    end

    def then_find_latest(method)
      @chain << create_generator(method, :latest)
      self
    end

    def each
      from = @options[:from]
      while true do
        from += 1
        next_date = @chain.first.step(from)
        yield @chain[1..-1].inject(next_date) { |date, generator| generator.step(date) }
        from = next_date
      end
    end

    private

    def parse(options)
      options[:from] ||= Date.today
      if options[:from].is_a? String
        iso = options[:from] =~ /\d{4}-\d{2}-\d{2}/
        raise ArgumentError, 'Please use ISO dates (YYYY-MM-DD) as those are not ambigious.' unless iso
        options[:from] = Date.parse(options[:from])
      end
      options
    end

    def create_generator(name, direction)
      class_name = name.to_s.classify + 'Generator'
      generator_class = Upcoming.const_get class_name
      generator_class.new(choose: direction)
    end

  end
end
