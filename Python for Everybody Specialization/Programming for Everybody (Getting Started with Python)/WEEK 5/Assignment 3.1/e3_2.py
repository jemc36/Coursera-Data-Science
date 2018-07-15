hours = input('Enter Hours:')
rate = input('Enter Rate:')
try:
    h = float(hours)
    r = float(rate)
except:
    print('Error, please enter numeric input')
    quit()

if h <= 40:
    money = str(h*r)
else:
    money = str(40*r+(h-40)*r*1.5)
print(money)
