# MethodCallCheck

This gem lets you track method calls in your Ruby application. You might want to do this so you
know if it is safe to delete a method you think isn't being called anywhere.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_call_check'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_call_check

## Usage

Use `is_method_called?` and `is_class_method_called?` to register and record
calls to instance and class methods.

```ruby
  class TestObject

    extend MethodCallCheck::InstanceMethodCheck
    extend MethodCallCheck::ClassMethodCheck

    def method_to_test
    end
    is_method_called? :method_to_test

    def self.class_method_to_test
    end
    is_class_method_called? :class_method_to_test

  end
```

Right now, there's no interface to see if the methods have been called. So
you might call this a work in progress!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jslate/method_call_check. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
