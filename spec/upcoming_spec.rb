require 'spec_helper'

describe Upcoming do

  context 'translates "every" to factory configuration' do
    When(:factory) { Upcoming.every(:bamboo) }
    Then { factory.must_be_kind_of Upcoming::Factory }
    And { factory.options[:every] == :bamboo }
  end

end
