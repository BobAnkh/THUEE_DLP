#!/usr/bin/env python
# -*- coding: utf-8 -*-

i = 0
f1 = open('cpu_instruction.txt', 'w+')
with open('cputestinst', 'r') as f:
    for line in f:
        line = line.strip('\n')
        print("9'd", i, ":    Instruction <= 32'h", line, ";", sep='', file=f1)
        i = i + 1
