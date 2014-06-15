require 'spec_helper'

describe Upcoming::DayGenerator do

  Given(:subject) { Upcoming::DayGenerator.new }

  context 'returns the following day' do
    When(:result) { subject.next(Date.parse('2001-12-31')) }
    Then { result == Date.parse('2002-01-01') }
  end

end
