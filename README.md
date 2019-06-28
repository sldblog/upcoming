:warning: https://github.com/gocardless/business implements most of this gem's functionality and has
better support. Did you consider that instead? :smile:



# upcoming

[![Build Status](https://travis-ci.org/sldblog/upcoming.svg)](https://travis-ci.org/sldblog/upcoming)
[![Code Climate](https://codeclimate.com/github/sldblog/upcoming.png)](https://codeclimate.com/github/sldblog/upcoming)

Recurring date sequence generator.

The current version is [![Gem Version](https://badge.fury.io/rb/upcoming.svg)](http://badge.fury.io/rb/upcoming). Please see the [CHANGELOG](CHANGELOG.md) for changes.

## Examples

`Upcoming::Factory.every` will return an infinite sequence that is defined by the generators called.

Please find the integration test examples in [`spec/integration_spec.rb`](spec/integration_spec.rb).

```ruby
# running on 20th of June, 2014
> factory = Upcoming::Factory.every(:last_day_of_month)
=> #<Upcoming::Factory:0xb8ba6838 @options={:from=>#<Date: 2014-06-20 ((2456829j,0s,0n),+0s,2299161j)>},
     @chain=[#<Upcoming::LastDayOfMonthGenerator:0xb8ba6310 @choose=:first>]>

> factory.take(12).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-08-31", "2014-09-30", "2014-10-31", "2014-11-30",
    "2014-12-31", "2015-01-31", "2015-02-28", "2015-03-31", "2015-04-30", "2015-05-31"]
```

It is possible to chain methods together. Any number of chains can be added.

Chaining forward in time is done via `then_find_upcoming`:

```ruby
> Upcoming::Factory.every(:last_day_of_month).then_find_upcoming(:working_day).take(12).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-09-01", "2014-09-30", "2014-10-31", "2014-12-01",
    "2014-12-31", "2015-02-02", "2015-03-02", "2015-03-31", "2015-04-30", "2015-06-01"]
```

Stepping backwards in time is done via `then_find_preceding`:

```ruby
> Upcoming::Factory.every(:last_day_of_month, from: '2014-08-20').then_find_preceding(:working_day).first
=> #<Date: 2014-08-29 ((2456899j,0s,0n),+0s,2299161j)>
```

Chaining the same method has no effect:

```ruby
Upcoming::Factory.every(:last_day_of_month, from: '2014-06-20')
  .then_find_upcoming(:working_day)
  .take(3).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-09-01"]

Upcoming::Factory.every(:last_day_of_month, from: '2014-06-20')
  .then_find_upcoming(:working_day)
  .then_find_upcoming(:working_day)
  .then_find_upcoming(:working_day)
  .take(3).map(&:iso8601)
=> ["2014-06-30", "2014-07-31", "2014-09-01"]
```

This is due to the current implementation, which only moves dates when "generators" do not "match" the date being tested.
Ie. if the date being tested is a Monday, all 3 "working day" generators will say "yes, it's a working day" and will not attempt to find another date.

## Generators

The available generators are in `lib/upcoming/generators`. They are mapped to the symbol by converting snake case to camel case and postfixing `Generator`. They can be anywhere in the load path.

## License

MIT
