require 'spec_helper'

describe Upcoming::Factory do
  class Upcoming::FizzGenerator < Upcoming::Generator
    def valid?(date)
      date.day % 3 == 0
    end
  end

  class Upcoming::BuzzGenerator < Upcoming::Generator
    def valid?(date)
      date.day % 5 == 0
    end
  end

  Given(:fixed_date) { Date.parse('2014-06-15') }
  When(:result) do
    Date.stub :today, fixed_date do
      subject.take(3).map(&:iso8601)
    end
  end

  context 'must be enumerable' do
    Given(:subject) { Upcoming::Factory.every(:fizz) }
    Then { subject.class.include? Enumerable }
    Then { subject.respond_to? :each }
  end

  context '#every' do
    context 'generates a sequence of days matching method given' do
      Given(:subject) { Upcoming::Factory.every(:fizz) }
      Then { result == %w(2014-06-18 2014-06-21 2014-06-24) }
    end

    context 'generates a sequence from the given start date' do
      Given(:subject) { Upcoming::Factory.every(:fizz, from: date) }

      context 'given as ISO date' do
        Given(:date) { '2014-06-20' }
        Then { result == %w(2014-06-21 2014-06-24 2014-06-27) }
      end

      context 'given as Date object' do
        Given(:date) { Date.parse('2014-05-01') }
        Then { result == %w(2014-05-03 2014-05-06 2014-05-09) }
      end

      context 'given something responding to :to_date' do
        Given(:date) { OpenStruct.new(to_date: Date.parse('2014-08-17')) }
        Then { result == %w(2014-08-18 2014-08-21 2014-08-24) }
      end

      context 'generates error if given as non-ISO date' do
        Given(:date) { '01/05/2014' }
        Then { result == Failure(ArgumentError, /Please use ISO dates \(YYYY-MM-DD\) as those are not ambiguous/) }
      end
    end
  end

  context 'chained generators' do
    class Upcoming::MonthAgoIfTwentyFifthGenerator < Upcoming::Generator
      def step(date)
        return date.prev_month if date.day == 25
        date
      end
    end

    context 'chains do not alter main sequence' do
      Given(:subject) { Upcoming::Factory.every(:buzz).then_find_preceding(:month_ago_if_twenty_fifth) }
      Then { result == %w(2014-06-20 2014-05-25 2014-06-30) }
    end

    context '#then_find_upcoming' do
      context 'modifies date found by moving to the next date that is a match' do
        Given(:subject) { Upcoming::Factory.every(:buzz).then_find_upcoming(:fizz) }
        Then { result == %w(2014-06-21 2014-06-27 2014-06-30) }
      end
    end

    context '#then_find_preceding' do
      context 'modifies date found by moving to the previous date that is a match' do
        Given(:subject) { Upcoming::Factory.every(:buzz).then_find_preceding(:fizz) }
        Then { result == %w(2014-06-18 2014-06-24 2014-06-30) }
      end
    end
  end

  context 'configured generators' do
    class Upcoming::DivisibleByNDayGenerator < Upcoming::Generator
      def initialize(options = {})
        super(options)
        @n = options.fetch(:n, 1)
      end

      def valid?(date)
        date.day % @n == 0
      end
    end

    context 'passes configuration to the generators' do
      Given(:subject) { Upcoming::Factory.every(:divisible_by_n_day, n: 2) }
      Then { result == %w(2014-06-16 2014-06-18 2014-06-20) }
    end
  end
end
