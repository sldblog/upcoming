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

  context 'with a set of non-working days configured' do
    Given(:good_friday) { Date.parse('2018-03-30') }
    Given(:easter_monday) { Date.parse('2018-04-02') }
    Given(:subject) { Upcoming::WorkingDayGenerator.new(holidays: [good_friday, easter_monday]) }

    Then { subject.valid?(good_friday - 1) }
    Then { !subject.valid?(good_friday) }
    Then { !subject.valid?(easter_monday) }
    Then { subject.valid?(easter_monday + 1) }
  end
end
