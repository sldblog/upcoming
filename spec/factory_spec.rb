require 'spec_helper'

describe Upcoming::Factory do

  let(:today) { Date.today }

  context 'generates any number of dates' do
    Given(:upcoming) { Upcoming::Factory.new }
    Then { upcoming.take(2).size == 2 }
    And { upcoming.take(20).size == 20 }
  end

  context 'configuration' do
    When(:upcoming) { Upcoming::Factory.new(config) }
    When(:options) { upcoming.options }

    context 'defaults to daily recurrence from today' do
      Given(:config) { {} }
      Then { options == {every: :day, from: today} }
    end

    context 'options is configured through constructor' do
      Given(:config) { {every: :bazooka, from: :other} }
      Then { options == config }
    end

    context 'dates' do
      context 'from dates other than strings are copied as-is' do
        Given(:config) { {from: 42} }
        Then { options[:from] == 42 }
      end

      context 'from date can be given as Date' do
        Given(:config) { {from: Date.parse('2001-10-10')} }
        Then { options[:from] == config[:from] }
      end

      context 'string ISO dates are converted automatically' do
        Given(:config) { {from: '2000-01-01'} }
        Then { options[:from] == Date.parse('2000-01-01') }
      end

      context 'non-ISO strings raise ambiguity error' do
        Given(:config) { {from: '12/01/2000'} }
        Then { upcoming.must_raise ArgumentError, /Please use ISO dates (YYYY-MM-DD) as those are not ambigious./ }
      end
    end
  end

  context 'execution' do
    module Upcoming
      class DeepThoughtGenerator
        def next(from)
          from + 42
        end
      end
    end

    Given(:upcoming) { Upcoming::Factory.new(every: :deep_thought) }

    context 'invokes generator based on the name of "every" parameter' do
      When(:result) { upcoming.first }
      Then { result == today + 42 }
    end

    context 'invokes generator with previous result iteratively' do
      When(:result) { upcoming.take(3) }
      Then { result == [today + 42, today + 84, today + 126] }
    end
  end

end
