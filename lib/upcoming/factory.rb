require 'date'
require 'active_support/core_ext'

module Upcoming
  class Factory
    include Enumerable
    attr_reader :options

    def initialize(options = {})
      @options = parse(options)
    end

    def each
      from = @options[:from]
      generator = Kernel::const_get("Upcoming::#{@options[:every].to_s.classify}Generator").new
      (1..Float::INFINITY).each do |n|
        date = generator.next(from)
        yield date
        from = date
      end
    end

    private

    def parse(options)
      options.dup.tap do |result|
        result[:every] ||= :day
        result[:from] ||= :today

        if result[:from].is_a? String
          iso = result[:from] =~ /\d{4}-\d{2}-\d{2}/
          raise ArgumentError, 'Please use ISO dates (YYYY-MM-DD) as those are not ambigious.' unless iso
          result[:from] = Date.parse(result[:from])
        end
        result[:from] = Date.today if result[:from] == :today
      end
    end

  end
end
