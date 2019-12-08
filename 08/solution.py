#! /bin/env python3

f = next(open("input.txt"))[:-1]

lines = [[int(x) for x in f[150*i:150*(i+1)]] for i in range(len(f)//150)]

img = [2] * 150

for l in lines:
    img = [new if old == 2 else old for (new, old) in zip(l, img)]

index = 0
for row in range(6):
    print(''.join(['█' if p else ' ' for p in img[row*25:(row+1)*25]]))

