import logging
from feed_grabber import FeedGrabber
import api.bitstamp.client


logger = logging.getLogger(__name__)


class BitStampGrabber(FeedGrabber):

    def __init__(self, *args, **kwds):
        super(BitStampGrabber, self).__init__(*args, **kwds)
        self.api = api.bitstamp.client.Public()

    def get_pair_trades(self, pair='BTC/USD'):
        '''bitstamp is only BTC'''
        logger.info('getting pair trades: %s' % pair)
        trades = self.api.transactions()
        return trades
