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

      context 'generates error if given as non-ISO date' do
        Given(:date) { '01/05/2014' }
        Then { result == Failure(ArgumentError, /Please use ISO dates \(YYYY-MM-DD\) as those are not ambigious/) }
      end
    end
  end

  context '#then_find_first' do
    context 'modifies date found by moving to the next date that is a match' do
      Given(:subject) { Upcoming::Factory.every(:buzz).then_find_first(:fizz) }
      Then { result == %w(2014-06-21 2014-06-27 2014-06-30) }
    end
  end

end
