module Upcoming
  class Generator
    def next(from)
      valid_offset = (0..Float::INFINITY).find { |offset| valid?(from + offset) }
      from + valid_offset
    end
  end
end
