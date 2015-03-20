import os
import yaml

AUTH_YAML = os.path.join(os.path.dirname(__file__), 'auth.yaml')

if not os.path.exists(AUTH_YAML):
    print 'Missing: %s' % AUTH_YAML
    exit()
auth = yaml.load(open(AUTH_YAML))
print auth

class TwitterAuth:
    # Go to http://dev.twitter.com and create an app.
    # The consumer key and secret will be generated for you after
    consumer_key = auth['consumer_key']
    consumer_secret = auth['consumer_secret']

    # After the step above, you will be redirected to your app's page.
    # Create an access token under the the "Your access token" section
    access_token = auth['access_token']
    access_token_secret = auth['access_token_secret']
