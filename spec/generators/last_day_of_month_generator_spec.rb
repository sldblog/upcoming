require 'spec_helper'

describe Upcoming::LastDayOfMonthGenerator do
  Given(:subject) { Upcoming::LastDayOfMonthGenerator.new }
  When(:valid) { subject.valid?(Date.parse(date)) }

  context 'start of the month is invalid' do
    Given(:date) { '2014-06-01' }
    Then { !valid }
  end

  context 'middle of the month is invalid' do
    Given(:date) { '2014-06-15' }
    Then { !valid }
  end

  context 'last day of the month is valid' do
    Given(:date) { '2014-05-31' }
    Then { valid }
  end

  context 'last day of February in a leap year is valid' do
    Given(:date) { '2012-02-29' }
    Then { valid }
  end
end
