#!/usr/bin/env python
import yaml
import logging
from pprint import pformat as pretty


logger = logging.getLogger('root')


class Whitelist(logging.Filter):
    def __init__(self, *whitelist):
        self.whitelist = [logging.Filter(name) for name in whitelist]

    def filter(self, record):
        return any(f.filter(record) for f in self.whitelist)


def setup_logging():
    FORMAT = '[%(asctime)-15s] %(name)23s: %(message)s'
    logging.basicConfig(format=FORMAT, level=logging.DEBUG)
    for handler in logging.root.handlers:
        handler.addFilter(Whitelist('root'))


if __name__ == '__main__':
    print 'yo!'
    setup_logging()
    # get_bitstamp_feed
    config = dict()
    # config = yaml.load(open('config.yaml'))
    logger.info('Start grabbing feed from bitstamp')
    from exchanges.bitstamp import BitStampGrabber
    feed_grabber = BitStampGrabber(config)
    trades = feed_grabber.get_pair_trades(pair='BTC/USD')
    logger.info(pretty(trades))

