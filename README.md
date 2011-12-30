lamson-research
===============

*** NOTE: You probably want to spoof your domain as sanderslabs.us for any of this to work ***
To do this, open up your `/etc/hosts` file and add an entry like:

    127.0.0.1       sanderslabs.us



To install:

    $ cd scripts
    $ ./install.sh

To run the development server:

    $ cd scripts
    $ ./runserver.sh

To test out sending an email with an attachment (while development server is running):

    $ cd scripts
    $ ./send-test-email.sh

A good place to start hacking is the `START` function in `themailserver/app/handlers/sample.py`.

Modify or copy the `scripts/send-test-email.sh` script to suit your needs for testing.
