# jsl

Slice and dice JSON at the command line.

## Installation

    gem install jsl

## Ideas

- Look at Dir.glob implementation
- regex instead of glob?
- SAX-based parser like https://bitbucket.org/webmat/htmlparser.js

## Usage

By default, `jsl` outputs one value per line. Unless --strict is specified,
it may not be a strict JSON string.

    # Note: ohai outputs information about your machine in JSON.
    $ gem install ohai
    $ ohai | jsl /os
    darwin

    $ aws ec2 run-instances [...] | jsl InstanceId
    i-beef42

Given

```JSON
{ "languages"
, { "ruby": { "version": "2.0.0" }
  , "nodejs": { "version": "0.10.22" }
  //...
  }
}
```

    $ ohai | jsl '/languages/*'
    { "version": "2.0.0" }
    { "version": "0.10.22" }

    $ ohai | jsl '/languages/*' --keys
    ruby
    nodejs
    perl
    php
    python

    $ ohai | jsl '/languages/*' --all
    { "ruby": { "version": "2.0.0", ...} }
    { "nodejs": {...} }

## Contributing

1. Fork it ( http://github.com/webmat/jsl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
