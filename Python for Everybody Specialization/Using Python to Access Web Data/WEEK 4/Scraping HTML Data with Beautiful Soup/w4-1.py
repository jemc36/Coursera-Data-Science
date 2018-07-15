import re
from urllib.request import urlopen
from bs4 import BeautifulSoup
import ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')
html = urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, "html.parser")

tags = soup('span')
count = 0
sum = 0
for tag in tags:
    x = re.findall('[0-9]+',str(tag))
    y =x.pop()

    sum = sum + int(y)
    count = count +1
print("count",count)
print("sum",sum)
