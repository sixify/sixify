import logging
from feed_grabber import FeedGrabber
import urllib2
import json
import time

logger = logging.getLogger(__name__)


class BlockChainGrabber(FeedGrabber):

    def __init__(self, *args, **kwds):
        super(, self).__init__(*args, **kwds)

    def get_latest_transactions(self, number_of_blocks=12);
        response = urllib2.urlopen('https://blockchain.info/latestblock')
        last_block = json.load(response)['height']
        txs = []
        for i in range(0, number_of_blocks):
            block_index = last_block - i
            response = urllib2.urlopen('https://blockchain.info/rawblock/' + str(last_block))
            block_txs = json.load(response)['tx']
            # remove unneeded data
            txs_data = map(_filter_data, block_txs)
            txs += txs_data
        return txs

    def _filter_data(block_tx):
        out =  dict(
                time        = block_tx['time'],
                size        = block_tx['size'],
                vout_sz      = block_tx['vout_sz'],
                vin_sz      = block_tx['vin_sz'],
                relayed_by  = block_tx['relayed_by'],
                )

        # calculate total output value
        outputs = map(lambda itx: itx['value'], block_tx['out'])
        out['output_value'] = sum(outputs)

        return out
