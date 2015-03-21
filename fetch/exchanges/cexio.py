import logging
from feed_grabber import FeedGrabber
from api.cexapi import cexapi


logger = logging.getLogger(__name__)


class CexioGrabber(FeedGrabber):

    def __init__(self, *args, **kwds):
        super(CexioGrabber, self).__init__(*args, **kwds)
        self.api = cexapi.API('', '', '')

    def get_pair_trades(self, pair='BTC/USD'):
        logger.info('getting pair trades: %s' % pair)
        # get latest
        trades = self.api.api_call('trade_history', {}, 0, pair)
        tid = trades[0]['tid']
        for num in range(2, 6):
            since_tid = tid - num * len(trades)
            trades += self.api.trade_history(couple='BTC/USD', since=since_tid)
        logger.info('CEXIO grabbed (%d) trades' % len(trades))
        return trades
