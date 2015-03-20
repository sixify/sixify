#!/usr/bin/env python
'''
Very simple (non-production) Twitter stream example

1. Download / install python and tweepy (pip install tweepy)
2. Fill in information in auth.py
3. Run as: python streaming_simple.py
4. It will keep running until the user presses ctrl+c to exit

All output stored to output.json (one tweet  per line)
Text of tweets also printed as received (see note about not doing this in
production (final) code
'''
from __future__ import print_function
from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream
import json
from auth import TwitterAuth


class StdOutListener(StreamListener):

    def __init__(self):
        # Create a file to store output. "a" means append
        # (add on to previous file)
        self.output_handler = open("output.json", "a")

    def on_data(self, data):
        '''
        This function gets called every time a new tweet is received on the
        stream.
        '''
        #Just write data to one line in the file
        self.output_handler.write(data)

        #Convert the data to a json object (shouldn't do this in production;
                                           # might slow down and miss tweets)
        j = json.loads(data)

        #See Twitter reference for what fields are included --
        # https://dev.twitter.com/docs/platform-objects/tweets
        text = j["text"]  # The text of the tweet
        print(text)  # Print it out

    def on_error(self, status):
        print("ERROR")
        print(status)

    def close(self):
        #Close the
        self.output_handler.close()


if __name__ == '__main__':
    #Create the listener
    listner = StdOutListener()

    try:
        auth = OAuthHandler(TwitterAuth.consumer_key,
                            TwitterAuth.consumer_secret)
        auth.set_access_token(TwitterAuth.access_token,
                              TwitterAuth.access_token_secret)

        # Connect to the Twitter stream
        stream = Stream(auth, listner)

        # Terms to track
        stream.filter(track=["BTC"])

        #Alternatively, location box  for geotagged tweets
        #stream.filter(locations=[-0.530, 51.322, 0.231, 51.707])

    except KeyboardInterrupt:
        #User pressed ctrl+c -- get ready to exit the program
        pass

    # shutdown listener
    listner.close()
