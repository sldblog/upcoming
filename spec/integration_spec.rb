require 'spec_helper'

describe 'working_day' do
  Given(:f) { Upcoming::Factory }

  context 'finding the next working day after a Friday' do
    # 2018-08-03 is a Friday: the next working day is Monday, 6th
    Then { Date.parse('2018-08-06') ==
           f.every(:working_day, from: '2018-08-03').first }
  end

  context 'finding the next non-holiday working day' do
    # 2018-08-24 is a Friday, Monday 27th is a holiday: next working day is Tuesday, 28th
    Then { Date.parse('2018-08-28') ==
           f.every(:working_day, from: '2018-08-24', holidays: ['2018-08-27']).first }
  end

  context 'finding the working day preceding the last day of the month' do
    # The last day of August 2014 was a Sunday, 31st August 2014.
    # The nearest preceding working day was Friday, 29th.
    Then { Date.parse('2014-08-29') ==
           f.every(:last_day_of_month, from: '2014-08-20').then_find_preceding(:working_day).first }
  end

  context 'finding the first working day at or after the end of the month' do
    # The last day of July 2014 was a Thursday, 31st July 2014
    # The upcoming working day is the same day
    Then { Date.parse('2014-07-31') ==
           f.every(:last_day_of_month, from: '2014-07-20').then_find_upcoming(:working_day).first }

    # The last day of August 2014 was a Sunday, 31st August 2014
    # The upcoming working day after that was Monday, 1st September 2014
    Then { Date.parse('2014-09-01') ==
           f.every(:last_day_of_month, from: '2014-08-20').then_find_upcoming(:working_day).first }
  end
end
