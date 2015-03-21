#!/usr/bin/env python
import os
import sys
import json
from glob import glob

location = os.path.join(os.path.dirname(__file__),
                        'visualize', 'data')


def gen_data_json_list(name, ext='txt'):
    # List
    json_list = [filename.replace('visualize/', '') for filename in
                 glob(location + '/sixify_*_*.%s' % ext)]

    # print json_list
    # Write
    output_path = os.path.join(location, name)
    with file(output_path, 'w+') as output:
        output.write(json.dumps(json_list))


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print 'Specify list filename'
        exit()
    gen_data_json_list(sys.argv[1])
