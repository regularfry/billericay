bill-unattended-test
====================


This is a Ruby implementation of
https://github.com/ldabiralai/bill-unattended-test.  It uses Cuba,
Puma and Haml to serve a simple rendering of a customer's bill.

The HTML is tested under Firefox and Chrome on Linux. Your mileage may
vary on other platforms.



Running locally
---------------

This application was developed against MRI version 2.1.3, in an
[rv](https://github.com/regularfry/rv.git) environment. Rvm and rbenv
should also work, but have not been tested.

- `bundle install` to install the gems, then
- `puma config.ru` to run the server.
- Open http://localhost:9292/ in a browser to see the rendered statement.


Tests
-----

There are unit tests in `test/unit`, and a couple of acceptance tests
in `test/acceptance` which need run under capybara, and are tested
with the selenium-webkit driver.

The acceptance tests use a local (in-process) web server instance to
avoid hitting the remote endpoint during tests; the bill.json file
provided in the bill-unattended-test repository is used as static
sample data.


Deployment
----------

The application is deployed to
`http://bill.default.alex.uk0.bigv.io/`. This is a Debian Wheezy
virtual machine.

It is deployed by building packages with
[au](http://github.com/regularfry/au.git), which are then rsynced to
an apt repository local to the VM. The new code in a release is
installed by a standard `apt-get update && apt-get upgrade` call.

The server process is run under `runit`, and puma is proxied behind
nginx.  The config files and run scripts to do this can be made
available.


Author
------

Alex Young <alex@blackkettle.org>
