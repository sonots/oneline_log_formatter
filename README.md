# OnelineLogFormatter

A logger formatter to output each log with in line forcely

## What is this for?

Rails default log formatter outputs backtrace in multiple lines, and it makes difficult to parse the log.

This log formatter replaces sthe line feed characters `\n` with `\\n` so that log messages will be in one line.

## Installation

Add this line to your application's Gemfile:

    gem 'oneline_log_formatter'

And then execute:

    $ bundle

## How to use

```ruby
require 'logger'
require 'oneline_log_formatter'

logger = Logger.new(STDOUT)
logger.formatter = OnelineLogFormatter.new
logger.info("foo\nbar")
```

which outputs logs like

```
20150423T00:00:00+09:00 [INFO] foo\\nbar
```

## Rails

Configure at `config/application.rb`

```ruby
config.logger.formatter = OnelineLogFormatter.new
```

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

See [LICENSE.txt](LICENSE.txt) for details.
