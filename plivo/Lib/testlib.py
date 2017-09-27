import urllib
import json
import sys

def url_encode(params):
    return urllib.urlencode(params)

def json_load(json_string):
    return json.loads(json_string)

def json_dumps(json_object):
    return json.dumps(json_object)