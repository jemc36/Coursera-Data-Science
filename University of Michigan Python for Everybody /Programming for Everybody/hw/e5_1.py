tot = 0.0
num = 0
while True:
    sval = input('Enter a number: ')
    if sval == 'done':
        break
    try:
        fval = float(sval)
    except:
        print('Invalid input')
        continue
    #print(fval)
    num += 1
    tot += fval

#print('ALL DONE')
print(tot, num, tot/num)
