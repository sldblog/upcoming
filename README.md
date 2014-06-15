# upcoming

[![Build Status](https://travis-ci.org/sldblog/upcoming.svg)](https://travis-ci.org/sldblog/upcoming)
[![Gem Version](https://badge.fury.io/rb/upcoming.png)](http://badge.fury.io/rb/upcoming)

Recurring date sequence generator.

## Examples

```ruby
# running on 15th of June, 2014
> factory = Upcoming.every(:last_day_of_month)
=> #<Upcoming::Factory:0xb8d734e0 @options={:every=>:last_day_of_month, :from=>#<Date: 2014-06-15 ((2456824j,0s,0n),+0s,2299161j)>}>

> factory.first
=> #<Date: 2014-06-30 ((2456839j,0s,0n),+0s,2299161j)>

> factory.take(12).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-08-31", "2014-09-30", "2014-10-31", "2014-11-30", "2014-12-31", "2015-01-31", "2015-02-28", "2015-03-31", "2015-04-30", "2015-05-31"]
```

The available generators are in `lib/upcoming/generators`. They are mapped to the symbol by converting snake case to camel case and postfixing `Generator`. They can be anywhere in the load path.

## Todo

Chain generators together with tests, modifying the result to the next matching either forwards or backwards. If, for example, I want to know the dates for all payments that will happen on last day of the month -- except when that's not a working day in which case it should arrive the working day before.

```ruby
> Upcoming.every(:last_day_of_month, from: '2014-08-20').then_test_for(:working_day, on_fail: :previous).first
=> 2014-08-29
```

## License

MIT
