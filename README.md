# mindbody-integration

[![Build Status](https://magnum.travis-ci.com/radoi90/mindbody-fitter.svg?token=h7yztF3b263no45wNybc&branch=master)](https://magnum.travis-ci.com/radoi90/mindbody-fitter)
[![Code Climate](https://codeclimate.com/repos/54c1657ae30ba06a85003f57/badges/3e7aaf94542b72f7f3bb/gpa.svg)](https://codeclimate.com/repos/54c1657ae30ba06a85003f57/feed)
[![Test Coverage](https://codeclimate.com/repos/54c1657ae30ba06a85003f57/badges/3e7aaf94542b72f7f3bb/coverage.svg)](https://codeclimate.com/repos/54c1657ae30ba06a85003f57/feed)

[MINDBODY][] provides a SOAP based API. This is a RESTful wrapper around some of the main MINDBODY functionality.

This is built for the Fitter iOS app, as a means to integrate MINDBODY data from
affiliated clients. It allows the Fitter web-service to programatically pull in 
customer, schedule and location MINDBODY data and to schedule class appointments.

The [live version][] is hosted on [Heroku][]. It's a simple [Sinatra][] application, 
re-routing RESTful calls to MINDBODY's SOAP API, through the Ruby [mindbody-api][] gem.
[MiniTest][] and [VCR][] are used for testing and mocking web requests respectively.

## Usage

It is targeted against Ruby 2.2.0. You'll also need [Bundler][].

```bash
bundle install
bundle exec rackup
```

Tests can be run using `rake`:

```bash
rake
```

## License

Copyright (c) 2014 Get Fitter.

[MINDBODY]: https://www.mindbodyonline.com/
[live version]: https://mindbody-fitter.herokuapp.com/
[mindbody-api]: https://github.com/wingrunr21/mindbody-api
[Heroku]: http://heroku.com/
[Sinatra]: http://www.sinatrarb.com/
[MiniTest]: https://github.com/seattlerb/minitest
[VCR]: https://github.com/vcr/vcr
[Bundler]: http://bundler.io
