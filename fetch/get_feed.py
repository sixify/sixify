#!/usr/bin/env python
import yaml
import logging
from pprint import pformat as pretty
import pandas
import pandas.io as pio
from cStringIO import StringIO


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


def export_csv(filename, data):
    logger.info('Exporting JSON into CSV dataframe: %s' % filename)
    frame = pandas.DataFrame.from_dict(data)
    frame.to_csv(filename)


def get_bitstamp_btcusd(config):
    logger.info('Start grabbing feed from bitstamp')
    from exchanges.bitstamp import BitStampGrabber
    feed_grabber = BitStampGrabber(config)
    trades = feed_grabber.get_pair_trades(pair='BTC/USD')
    # logger.info(pretty(trades))
    export_csv('../analyze/input_feeds/sixify_bitstamp_btcusd.csv', trades)


def get_forex_yahoo_usdeur(config):
    '''Get EUR/USD pair trades form yahoo'''


def get_blockchaininfo_transactions(config):
    from blockchain.blockchain import BlockChainGrabber
    feed_grabber = BlockChainGrabber(config)
    transactions = feed_grabber.get_latest_transactions()
    export_csv('../analyze/input_feeds/sixify_blockchaininfo_'
               'transactions.csv', transactions)


if __name__ == '__main__':
    setup_logging()
    # get_bitstamp_feed
    config = dict()
    # config = yaml.load(open('config.yaml'))
    get_bitstamp_btcusd(config)
    get_forex_yahoo_usdeur(config)
    get_blockchaininfo_transactions(config)
