require 'spec_helper'

describe Upcoming::Generator do

  class Upcoming::FakeGenerator < Upcoming::Generator
    def initialize(options = {})
      super
      @valid_dates = {}
    end

    def make_valid(date)
      @valid_dates[Date.parse(date)] = true
    end

    def valid?(date)
      @valid_dates[date]
    end
  end

  def step(date)
    result = subject.step(Date.parse(date))
    result and result.iso8601
  end

  Given(:subject) { Upcoming::FakeGenerator.new }

  context 'returns the same date if it is valid' do
    Given(:start_date) { '2014-05-19' }
    When { subject.make_valid(start_date) }
    Then { step(start_date) == start_date }
  end

  context 'forward in time' do
    context 'returns the first valid date, checking all dates in sequence' do
      When { subject.make_valid('2014-05-20') }
      When { subject.make_valid('2014-06-20') }
      Then { step('2014-05-19') == '2014-05-20' }
      Then { step('2014-05-21') == '2014-06-20' }
      Then { step('2014-06-10') == '2014-06-20' }
    end

    context 'returns nil if there is no valid date within 1 year' do
      # implement a custom +step+ method in your generator if you need this
      When { subject.make_valid('2020-01-01') }
      Then { step('2018-12-31') == nil }
      Then { step('2019-01-01') == '2020-01-01' }
    end
  end

  context 'backward in time' do
    Given(:subject) { Upcoming::FakeGenerator.new(choose: :latest) }

    context 'returns the closest past date, checking all dates in sequence' do
      When { subject.make_valid('2010-03-04') }
      When { subject.make_valid('2010-09-21') }
      Then { step('2010-09-22') == '2010-09-21' }
      Then { step('2010-09-20') == '2010-03-04' }
      Then { step('2010-06-01') == '2010-03-04' }
    end

    context 'returns nil if there is no valid date within -1 year' do
      # implement a custom +step+ method in your generator if you need this
      When { subject.make_valid('2010-01-01') }
      Then { step('2011-01-02') == nil }
      Then { step('2011-01-01') == '2010-01-01' }
    end
  end

end
