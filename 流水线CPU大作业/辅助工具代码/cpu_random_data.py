#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
a = []
f1 = open('cpu_random_data.txt', 'w+')
f2 = open('cpu_random_data_sorted.txt', 'w+')
f3 = open('cpu_random_data_load.txt', 'w+')
for i in range(128):
    r_int = random.randint(1, 32767)
    print(r_int, file=f1)
    a.append(r_int)
    hex_r_int = hex(r_int)
    j = 4 * i + 64
    str = f"addi $t0, $zero, {hex_r_int}\nsw $t0, {j}($s4)"
    print(str, file=f3)
a.sort()
for i in range(len(a)):
    print(hex(a[i]), file=f2)
