import logging
from feed_grabber import FeedGrabber
import btceapi


logger = logging.getLogger(__name__)


class BtceGrabber(FeedGrabber):

    def get_pair_trades(self, pair='BTC/USD'):
        logger.info('getting pair trades: %s' % pair)
        # get latest
        pair = pair.lower().replace('/', '_')
        history = btceapi.getTradeHistory(pair)
        trades = list()
        for row in history:
            trade = row.__getstate__()
            trade['date'] = str(trade['date'].strftime("%s"))
            trade['price'] = str(trade['price'])
            trade['tid'] = str(trade['tid'])
            trade['amount'] = str(trade['amount'])
            # print trade
            # exit()
            trades.append(trade)
        logger.info('BTC-e grabbed (%d) trades' % len(trades))
        return trades
