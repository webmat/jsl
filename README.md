# Jason

Slice and dice JSON at the command line.

## Installation

    gem install jason

## Ideas

- Look at Dir.glob implementation
- SAX-based parser like https://bitbucket.org/webmat/htmlparser.js

## Usage

    - read key values
    - reference array locations
    - read key names

    # ohai outputs information about your machine in JSON.
    gem install ohai
    $ ohai | jason /os
    darwin

    # like ls?
    $ ohai | jason /languages
    ruby
    nodejs
    perl
    php
    python

    $ ohai | jason -r /languages

    # json output or explicit?
    $ ohai | jason /languages
    {
      "ruby": { "version": "2.0.0", ...},
      "nodejs": {...}
      ...
    }

    $ ohai | jason /languages/*
    "ruby": { "version": "2.0.0", ...},
    nodejs
    perl
    php
    python

    $ ohai | jason /languages/(*)
    ruby
    nodejs
    perl
    php
    python

## Contributing

1. Fork it ( http://github.com/<my-github-username>/jason/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
