SEARCH_QUERY_DICT = {'country_iso':'US','pattern':'2342'}
FIRST_NUMBER = '12342521239' # Hard coding Numbers for now
SECOND_NUMBER = '12342521240'
MESSAGE_PAYLOAD = {

    "src": FIRST_NUMBER,
    "dst" : SECOND_NUMBER,
    "text" : "Test Automation Message"
}
MESSAGE_QUEUED = 'message(s) queued'
PRICE_QUERY_DICT = {'country_iso':'US'}