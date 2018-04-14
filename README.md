# switchcreds

SwitchCreds is a simple gem that allows you to switch back and forth between different Amazon Web Services (AWS) accounts via the command line.  This is achieved by automatically updating your ~/.aws/credentials file to point your AWS Command Line Interface (CLI) and AWS Software Development Kit (SDK) calls to the appropriate account.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'switchcreds'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install switchcreds

## Usage

In order to use this gem there should be a single 'credentials' file in your ~/.aws directory.  This file should be duplicated and stored in a 'credentials_example' file.  Credentials for all other AWS account must be stored similarly, ex. 'credentials_example1', 'credentials_example2'.  The following example shows three different accounts that can be switched into:
- ~/.aws/credentials
- ~/.aws/credentials_personal
- ~/.aws/credentials_company1
- ~/.aws/credentials_company2

In order to switch between accounts run:

```
$ switchcreds -s
```
You should see:
```
CHOOSE FROM BELOW:

	0: personal1
	1: company1
	2: company2
```
Make a selection. 1 for example:
```
$ 1
********************************
* Using COMPANY1 creds now *
********************************
```
You are now interacting with your Company1 AWS account via command line and SDK calls unless otherwise overridden.

## Development

<!-- TODO: add tests so this section is real.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. -->

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags.

Build the gem with `gem build switchcreds.gemspec`.

Push the `.gem` file to [rubygems.org](https://rubygems.org) using the correct version: `gem push switchcreds-x.x.x.gem`.

## Contributing

In the very likely scenario I've screwed something up or if you want to make improvements, it would be wicked awesome if you sent bug reports and updates to [the SwitchCreds repo](https://github.com/chrisLaflamme/switchcreds).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the switchcreds project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/switchcreds/blob/master/CODE_OF_CONDUCT.md).
