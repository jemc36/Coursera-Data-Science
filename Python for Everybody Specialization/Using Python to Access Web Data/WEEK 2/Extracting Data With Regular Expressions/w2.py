import re
fname = input('Input a file:')
fhand = open(fname)
count = 0
sumy = 0
for line in fhand:
    line = line.strip()
    if re.search('[0-9]+',line):
        y = re.findall('[0-9]+',line)
        y = list(map(int,y))
        for i in y:
            sumy = sumy + i
            count = count + 1
print('There are',count,'values with a sum=',sumy)
