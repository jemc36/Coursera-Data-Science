name = input("Enter file:")
if len(name) < 1 : name = "mbox-short.txt"
handle = open(name)
counts = dict()
for line in handle:
    line = line.rstrip()
    if not line.startswith('From ') : continue
    line2 = line.split()
    line3 = line2[5]
    line4 = line3.split(':')
    counts[line4[0]] = counts.get(line4[0], 0) + 1

for k, v in sorted(counts.items()):
    print(k,v)


    
