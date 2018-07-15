largest = None
smallest = None
while True:
    num = input("Enter a number: ")
    if num == "done":
        break
    try:
        intnum = int(num)
    except:
        print('Invalid input')
        continue
    if intnum > largest:
        largest = intnum
    if smallest is None:
        smallest = intnum
    elif intnum < smallest:
        smallest = intnum

print("Maximum is", largest)
print("Minimum is", smallest)
