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

    # see http://lamsonproject.org/docs/api/lamson.mail-pysrc.html
    # for API of the 'message' object
    logging.debug('Message is:\n"""\n%s\n"""' % message.body())

    for item in message.walk():
        print item
