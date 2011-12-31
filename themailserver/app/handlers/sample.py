import logging
from lamson.routing import route, route_like, stateless
from config.settings import relay
from lamson import view

# for now this only accepts ASCII. must look into unicode ranges in regular expressions
@route("(badformat)@(host)", badformat=".+")
@route("(address)@(host)", address="[a-zA-Z0-9\._]+")
@route("(address)\-(signal)@(host)", address="[a-zA-Z0-9\._]+", signal="[a-zA-Z0-9\._]+")
def START(message, address=None, signal=None, host=None, badformat=None):
    if badformat:
        logging.debug('Address "%s" is ambiguous. Addresses should be of the form user@example.com or user-signal@example.com where user and signal can only consist of characters in the set [a-zA-Z0-9], a period, or an underscore.' % (badformat))
    elif signal:
        logging.debug('Signal "%s" sent to %s' % (signal, address))
        if signal == 'clipboard':
            clipboard(message, address, host)
    else:
        logging.debug('Message sent to %s' % (address))
    logging.debug('Message is:\n"""\n%s\n"""' % message.body())

def clipboard(message, address, host):
    i = 0
    for attachment in message.walk():
        # the first attachment is actually just the message body
        if i > 0:
            try:
                logging.debug('Message contains attachment %s' % attachment.content_encoding)
            except:
                logging.debug('Message contains attachment with unknown encoding')

        # do some stuff with the file here, save it, add a DB record, etc
        i += 1
