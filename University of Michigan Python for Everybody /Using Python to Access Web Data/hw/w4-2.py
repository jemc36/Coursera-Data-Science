import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup
import ssl


ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')
count = input('Enter count: ')
pos = input('Enter position: ')

for i in range(int(count)):
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, 'html.parser')
    tags = soup('a')
    alllink = list()
    for tag in tags:
        link = tag.get('href',None)
        alllink.append(link)
    url = alllink[int(pos)-1]

urlspl=url.split('_')
furlsp=urlspl[2]
lname=furlsp.split('.')
print(lname[0])
