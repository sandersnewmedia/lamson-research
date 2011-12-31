
from lamson.routing import route, route_like, stateless
from config.settings import relay
from lamson import view


import logging



@route("(bad_address)@(host)", bad_address=".+")
@route("(address)@(host)", address="[a-zA-Z0-9\._]+")
@route("(address)\-(signal)@(host)", address=".+", signal=".+")
@stateless
def START(message, address=None, signal=None, host=None, bad_address=None):
    """
    This is the main point of entry for all incoming mail
    """

    if signal:
        return SIGNAL_RECEIVED(message, address, signal, host)

    elif bad_format:
        return BAD_ADDRESS(message, bad_address)

    else:
        return MESSAGE_RECEIVED(message, address, host)


def MESSAGE_RECEIVED(message, address, host):
    logging.debug('Normal message sent to %s@%s' % (address, host))
    return MESSAGE_RECEIVED


def BAD_ADDRESS(message, bad_address):
    logging.debug('Address "%s" is ambiguous. Addresses should be of the form user@example.com or user-signal@example.com where user and signal can only consist of characters in the set [a-zA-Z0-9], a period, or an underscore.' % badformat)
    return BAD_ADDRESS


def SIGNAL_RECEIVED(message, address, signal, host):
    logging.debug('Signal "%s" received for %s' % (signal, address))

    # handle signals here
    if signal == 'clipboard':
        return CLIPBOARD_SIGNAL_RECEIVED(message, address, signal, host)

    else:
        logging.debug('Nothing to do for signal "%s" for %s' % (signal, address))

    return SIGNAL_RECEIVED


def CLIPBOARD_SIGNAL_RECEIVED(message, address, signal, host):
    i = 0
    for attachment in message.walk():
        if i > 0:
            # the first attachment is actually just the message body so we skip it

            logging.debug('Message contains attachment %s' % attachment.content_encoding)
            # do_stuff_here()
        i += 1

    return CLIPBOARD_SIGNAL_RECEIVED
