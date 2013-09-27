# active_doc

active_doc is a gem that uses Capybara/RSpec tests as source material to generate user documentation.  The gem generates customer-facing html documentation with steps that correspond to steps within your tests.  If you want, you can also have ActiveDoc take screenshots at points within your steps.  ActiveDoc will place these screenshot images under the step where it was taken.  ActiveDoc can also flag documents whose source RSpec tests are not currently passing to indicate that the documented feature may currently be having problems.

## Installation

Add this line to your application's Gemfile:

    gem 'active_doc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_doc

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
