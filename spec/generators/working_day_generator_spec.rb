require 'spec_helper'

describe Upcoming::WorkingDayGenerator do

  Given(:subject) { Upcoming::WorkingDayGenerator.new }

  context 'returns upcoming Monday when Friday, Saturday or Sunday are given' do
    Given(:friday) { Date.parse('2014-06-13') }
    Given(:saturday) { Date.parse('2014-06-14') }
    Given(:sunday) { Date.parse('2014-06-15') }
    Given(:monday) { Date.parse('2014-06-16') }

    Then { subject.next(friday) == monday }
    Then { subject.next(saturday) == monday }
    Then { subject.next(sunday) == monday }
  end

  context 'returns next workday when given workday' do
    Given(:monday) { Date.parse('2014-06-16') }
    Given(:tuesday) { monday + 1 }
    Given(:wednesday) { tuesday + 1 }
    Given(:thursday) { wednesday + 1 }
    Given(:friday) { thursday + 1 }

    Then { subject.next(monday) == tuesday }
    Then { subject.next(tuesday) == wednesday }
    Then { subject.next(wednesday) == thursday }
    Then { subject.next(thursday) == friday }
  end

end
