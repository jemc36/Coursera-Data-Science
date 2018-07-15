import urllib.request, urllib.parse, urllib.error
import xml.etree.ElementTree as ET


address = input('Enter location: ')
url = address
print('Retrieving', url)
uh = urllib.request.urlopen(url)
data = uh.read()
print('Retrieved', len(data), 'characters')
print(data.decode())
tree = ET.fromstring(data)
counts = tree.findall('.//count')
sum = 0
for ctext in counts:
    cctext = int(ctext.text)
    sum = sum + cctext
print(sum)
