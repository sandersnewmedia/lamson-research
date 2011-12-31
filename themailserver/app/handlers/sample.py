
from lamson.routing import route, route_like, stateless
from config.settings import relay
from lamson import view

import logging

# TODO:
# - for now this only accepts ASCII. must look into unicode ranges in regular expressions
# - create a proper FSM state for handling the clipboard

@route("(badformat)@(host)", badformat=".+")
@route("(address)@(host)", address="[a-zA-Z0-9\._]+")
@route("(address)\-(signal)@(host)", address="[a-zA-Z0-9\._]+", signal="[a-zA-Z0-9\._]+")
def START(message, address=None, signal=None, host=None, badformat=None):
    """
    This is the main point of entry for all incoming mail
    """

    if badformat:
        logging.debug('Address "%s" is ambiguous. Addresses should be of the form user@example.com or user-signal@example.com where user and signal can only consist of characters in the set [a-zA-Z0-9], a period, or an underscore.' % badformat)

    elif signal:
        logging.debug('Signal "%s" received for %s' % (signal, address))

        # handle signals here
        if signal == 'clipboard':
            handle_clipboard(message, address, host)

        else:
            logging.debug('Nothing to do for signal "%s" for %s' % (signal, address))

    else:
        logging.debug('Normal message sent to %s' % address)

    #logging.debug('Message is:\n"""\n%s\n"""' % message.body())


def handle_clipboard(message, address, host):
    i = 0
    for attachment in message.walk():
        if i > 0:
            # the first attachment is actually just the message body so we skip it

            logging.debug('Message contains attachment %s' % attachment.content_encoding)
            # do_stuff_here()
        i += 1
