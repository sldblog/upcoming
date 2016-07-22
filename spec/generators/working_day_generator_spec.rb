require 'spec_helper'

describe Upcoming::WorkingDayGenerator do
  Given(:subject) { Upcoming::WorkingDayGenerator.new }

  context 'weekends are invalid' do
    Given(:saturday) { Date.parse('2014-06-14') }
    Given(:sunday) { Date.parse('2014-06-15') }

    Then { !subject.valid?(saturday) }
    Then { !subject.valid?(sunday) }
  end

  context 'weekdays are valid' do
    Given(:monday) { Date.parse('2014-06-16') }
    Given(:tuesday) { monday + 1 }
    Given(:wednesday) { tuesday + 1 }
    Given(:thursday) { wednesday + 1 }
    Given(:friday) { thursday + 1 }

    Then { subject.valid?(monday) }
    Then { subject.valid?(tuesday) }
    Then { subject.valid?(wednesday) }
    Then { subject.valid?(thursday) }
    Then { subject.valid?(friday) }
  end
end
