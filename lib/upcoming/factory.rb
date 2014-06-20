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
      new(options).then_find_first method
    end

    def then_find_first(method)
      @chain << create_generator(method)
      self
    end

    def each
      from = @options[:from]
      while true do
        from += 1
        date = @chain.inject(from) { |date, generator| generator.next(date) }
        yield date
        from = date
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

    def create_generator(name)
      class_name = name.to_s.classify + 'Generator'
      generator_class = Upcoming.const_get class_name
      generator_class.new
    end

  end
end
