#!/usr/bin/env python
import yaml
import json
import logging
from pprint import pformat as pretty
import pandas
import pandas.io as pio
from cStringIO import StringIO
from utils import invoke


logger = logging.getLogger('root')


class Whitelist(logging.Filter):
    def __init__(self, *whitelist):
        self.whitelist = [logging.Filter(name) for name in whitelist]

    def filter(self, record):
        return any(f.filter(record) for f in self.whitelist)


def setup_logging():
    FORMAT = '[%(asctime)-15s] %(name)23s: %(message)s'
    logging.basicConfig(format=FORMAT, level=logging.DEBUG)
    # for handler in logging.root.handlers:
    #     handler.addFilter(Whitelist('root', 'exchanges.cexio'))


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


def get_bitcoinavarage_btcusd(config):
    logger.info('Getting bitcoinavarage btcusd and volumes')
    invoke('curl -L https://api.bitcoinaverage.com/history/USD/'
           'per_minute_24h_sliding_window.csv > ../analyze/input'
           '_feeds/sixify_bitcoinavarage_minslidewin24.csv')
    invoke('curl -L https://api.bitcoinaverage.com/history/USD/'
           'volumes.csv > ../analyze/input_feeds/sixify_bitcoina'
           'varage_volumes.csv')


def get_okcoin_btcusd(config, pair='btcusd'):
    exchange = 'okcoin'
    (stdout, stderr) = invoke(
        'curl -kL https://www.okcoin.com/api/v1/trades.do\?symbol\='
        'btc_usd')
    trades = json.loads(stdout)
    csv_filename = '../analyze/input_feeds/sixify_%s_%s.csv' % \
                   (exchange, pair)
    export_csv(csv_filename, trades)


def get_kraken_btcusd(config, pair='btcusd'):
    exchange = 'kraken'
    logger.info('Grab %s' % exchange)
    (stdout, stderr) = invoke(
        'curl -kL https://api.kraken.com/0/public/Trades\?pair\=XBTUSD')
    rows = json.loads(stdout)['trades']
    # print trades
    csv_filename = '../analyze/input_feeds/sixify_%s_%s.csv' % \
                   (exchange, pair)
    export_csv(csv_filename, trades)


def get_cexio_btcusd(config, pair='btcusd'):
    exchange = 'cexio'
    logger.info('Grab %s' % exchange)
    from exchanges.cexio import CexioGrabber
    grabber = CexioGrabber(config)
    trades = grabber.get_pair_trades(pair='BTC/USD')
    # logger.info(pretty(trades))
    csv_filename = '../analyze/input_feeds/sixify_%s_%s.csv' % \
                   (exchange, pair)
    export_csv(csv_filename, trades)


def get_btce_btcusd(config, pair='btcusd'):
    exchange = 'btce'
    logger.info('Grab %s' % exchange)
    from exchanges.btce import BtceGrabber
    grabber = BtceGrabber(config)
    trades = grabber.get_pair_trades(pair='BTC/USD')
    # logger.info(pretty(trades))
    csv_filename = '../analyze/input_feeds/sixify_%s_%s.csv' % \
                   (exchange, pair)
    export_csv(csv_filename, trades)


def mine_stock_feeds():
    '''Get latest high-frequent exchange rates data from stocks API.'''
    config = dict()
    # config = yaml.load(open('config.yaml'))
    get_okcoin_btcusd(config)
    # get_kraken_btcusd(config)
    get_bitstamp_btcusd(config)
    get_forex_yahoo_usdeur(config)
    get_blockchaininfo_transactions(config)
    get_bitcoinavarage_btcusd(config)
    get_cexio_btcusd(config)
    get_btce_btcusd(config)


if __name__ == '__main__':
    setup_logging()
    mine_stock_feeds()


