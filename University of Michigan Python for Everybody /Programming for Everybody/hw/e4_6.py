h = input("Enter Hours:")
r = input("Enter Rate:")

def computepay(h,r):
    hrs = float(h)
    rate = float(r)
    if hrs <=40:
        money=str(hrs*rate)
    else:
        money=str(40*rate+(hrs-40)*1.5*rate)
    return money

p=computepay(h,r)
print(p)
