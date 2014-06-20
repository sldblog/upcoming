require 'spec_helper'

describe Upcoming::LastDayOfMonthGenerator do

  Given(:subject) { Upcoming::LastDayOfMonthGenerator.new }
  When(:valid) { subject.valid?(date) }

  context 'not valid on not last day of month' do
    Given(:date) { Date.parse('2014-06-15') }
    Then { !valid }
  end

  context 'valid on last day of month' do
    Given(:date) { Date.parse('2014-05-31') }
    Then { valid }
  end

  context 'valid on leap day' do
    Given(:date) { Date.parse('2012-02-29') }
    Then { valid }
  end

end
