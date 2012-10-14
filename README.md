[![Build Status](https://secure.travis-ci.org/brettweavnet/loggly-ruby-client.png)](http://travis-ci.org/brettweavnet/loggly-ruby-client)

loggly-ruby-client is a basic class with CLI for interacting with Loggly's search API.

## Installation

```
gem install loggly-ruby-client
```

## Getting Started

You can specify your credentials on the command line, however it is best to add them to a configuration file.

```
default:
  username: your_username
  password: your_password
```

## Usage - CLI

Performing basic search:

```
loggly-ruby-client -q testquery1
```

(If account is note specified loggly-ruby-client will look for the default account.)

Multiple queries can be specified and will be joined with **ANDs**:

```
loggly-ruby-client -q testquery1 -q testquery2
```

And inputs can be added, multile inputs will be joined with **ORs**:

```
loggly-ruby-client -q testquery1 -q testquery2 -i input1 -i input2
```

See help for full list of options:

```
loggly-ruby-client -h
```

## Usage - Class

Create a new LogglyRubyClient object:

```
require 'loggly-ruby-client'
loggly = LogglyRubyClient.new
```

Perform basic search:

```
loggly.search :from  => 'NOW-1HOUR',
              :query => ['testquery1'],
              :input => ['input1']
 
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
