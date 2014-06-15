require 'spec_helper'

describe Upcoming::LastDayOfMonthGenerator do

  Given(:subject) { Upcoming::LastDayOfMonthGenerator.new }
  When(:result) { subject.next(date) }

  context 'returns last day of month' do
    Given(:date) { Date.parse('2014-06-15') }
    Then { result == Date.parse('2014-06-30') }
  end

  context 'returns next months last day when called with last day' do
    Given(:date) { Date.parse('2014-05-31') }
    Then { result == Date.parse('2014-06-30') }
  end

  context 'returns leap day correctly in case of leap year' do
    Given(:date) { Date.parse('2012-01-31') }
    Then { result == Date.parse('2012-02-29') }
  end

end
