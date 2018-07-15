import urllib.request, urllib.parse, urllib.error
import json

while True:
    address = input('Enter location: ')
    if len(address) < 1: break

    #url = urllib.parse.urlencode({'address': address})
    url = address
    print('Retrieving', url)
    uh = urllib.request.urlopen(url)
    data = uh.read()
    print('Retrieved', len(data), 'characters')
    print(data.decode())


    info = json.loads(data)
    #print (info)
    comments = info['comments']
    #print(comments)

    count = 0
    sum = 0
    for item in comments:
        count = count + 1
        sum = sum + int(item['count'])
    print('count: ',count)
    print('sum: ',sum)
