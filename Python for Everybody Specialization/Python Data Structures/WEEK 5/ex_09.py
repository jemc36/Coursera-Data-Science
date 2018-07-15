fname = input('Enter File: ')
if len(fname) < 1:
    fname = 'clown.txt'
    hand = open(fname)
di = dict()
for lin in hand:
    lin = lin.rstrip()
    wds = lin.split()
    #print(wds)
    for w in wds:
        # if the key is not there the count is zero
        #print(w)
        #print('**',w,di.get(w,-99))
        #oldcount = di.get(w,0)
        #print(w,'old',oldcount)
        #newcount = oldcount + 1
        #di[w] = newcount
        #print(w,'new',newcount)
        # idiom: retrieve/create/update counter
        di[w] = di.get(w,0) + 1
        # print(w,'new',di[w])

        #if w in di:
        #    di[w] = di[w] + 1
            #print('**EXISTING**')
        #else:
        #    di[w] = 1
            #print('**NEW**')
        #print(di[w])

#print(di)

#now we want to find the most common bigword
largest = -1
theword = None
for k,v in di.items():
    #print (k, v)
    if v > largest:
        largest = v
        theword = k #capture/ remember the word is largest
print('Done', theword, largest)
