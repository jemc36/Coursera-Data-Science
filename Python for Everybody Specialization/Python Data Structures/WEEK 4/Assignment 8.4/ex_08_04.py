fname = input("Enter file name: ")
fh = open(fname)
lst = list()
allwords = list()
for line in fh:
    line = line.rstrip()
    words = line.split()
    allwords = allwords + words
for i in allwords:
    if i in lst:continue
    lst.append(i)
lst.sort()
print(lst)


"""
Method 2
"""

fhand = open('romeo.txt')
allwords = list()

for line in fhand:
    line = line.rstrip()
    spline = line.split()
    for word in spline:
        if word not in allwords:
            allwords.append(word)
print(sorted(allwords)) 
