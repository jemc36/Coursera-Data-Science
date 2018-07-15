han = open('mbox-short.txt')
for line in han:
    line = line.rstrip()
    # print('Line:',line)
    wds = line.split()
    #print('Words: ', wds)
    #if len(wds) < 3:
    #    continue
    if len(wds) < 3 | wds[0] != 'From':
        # print('Ignore')
        continue
    print(wds[2])
