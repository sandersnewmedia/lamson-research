import logging
from lamson.routing import route, route_like, stateless
from config.settings import relay
from lamson import view


@route("(address)@(host)", address="[^\+]+")
@route("(address)\+(signal)@(host)", address="[^\+]+", signal=".+")
def START(message, address=None, signal=None, host=None):
    if signal:
        logging.debug('signal "%s" sent to %s' % (signal, address))
    else:
        logging.debug('message sent to %s' % (address))
    logging.debug('Message is:\n"""\n%s\n"""' % message.body())
    i = 0
    for attachment in message.walk():
        # the first attachment is actually just the message body
        if i > 0:
            logging.debug('Message contains attachment %s' % attachment.content_encoding)
        i += 1
