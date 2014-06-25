# upcoming

[![Gem Version](https://badge.fury.io/rb/upcoming.png)](http://badge.fury.io/rb/upcoming)
[![Build Status](https://travis-ci.org/sldblog/upcoming.svg)](https://travis-ci.org/sldblog/upcoming)
[![Code Climate](https://codeclimate.com/github/sldblog/upcoming.png)](https://codeclimate.com/github/sldblog/upcoming)
[![Dependency Status](https://gemnasium.com/sldblog/upcoming.svg)](https://gemnasium.com/sldblog/upcoming)

Recurring date sequence generator.

## Examples

`Upcoming::Factory.every` will generate sequences using the given method. This uses an enumerator so any number of dates can be queried.

```ruby
# running on 20th of June, 2014
> factory = Upcoming::Factory.every(:last_day_of_month)
=> #<Upcoming::Factory:0xb82fb490 @options={:from=>#<Date: 2014-06-20 ((2456829j,0s,0n),+0s,2299161j)>}, @chain=[#<Upcoming::LastDayOfMonthGenerator:0xb82fb094>]>

> factory.first
=> #<Date: 2014-06-30 ((2456839j,0s,0n),+0s,2299161j)>

> factory.take(12).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-08-31", "2014-09-30", "2014-10-31", "2014-11-30", "2014-12-31", "2015-01-31", "2015-02-28", "2015-03-31", "2015-04-30", "2015-05-31"]
```

It is possible to chain methods together. Running sequentially, the methods will first test whether the date given for them is valid and if it is not, alter the previous result. Any number of chains can be added.

```ruby
> factory.then_find_first(:working_day).take(12).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-09-01", "2014-09-30", "2014-10-31", "2014-12-01", "2014-12-31", "2015-02-02", "2015-03-02", "2015-03-31", "2015-04-30", "2015-06-01"]
```

The available generators are in `lib/upcoming/generators`. They are mapped to the symbol by converting snake case to camel case and postfixing `Generator`. They can be anywhere in the load path.

## Todo

Chaining backwards:

```ruby
> Upcoming::Factory.every(:last_day_of_month, from: '2014-08-20').then_find_latest(:working_day).first
=> 2014-08-29
```

## License

MIT
