#!/usr/bin/env python

import sys
import re
from collections import deque

HEADER_LINE_COUNT = 1000
ADDITION_HEADER_LINES_IGNORE = 50
FOOTER_LINE_COUNT = 1000

REGEX = re.compile('Project Gutenberg(?i)')

header_lines = []

counter = 0
for l in sys.stdin:
    header_lines.append(l)
    counter += 1
    if counter == HEADER_LINE_COUNT: break

found = False
for i in xrange(len(header_lines)-1, 0, -1):
    l = header_lines[i]

    if REGEX.findall(l): found = True
    if found: header_lines[i] = None

header_lines = [l for l in header_lines if l]
header_lines = header_lines[ADDITION_HEADER_LINES_IGNORE:]

for l in header_lines: print l

lines = deque()

for l in sys.stdin:
    lines.append(l)

    if len(lines) > FOOTER_LINE_COUNT:
        popped_l = lines.popleft()
        

lines = list(lines)

found = False
for i, l in enumerate(lines):

    if REGEX.findall(l): found = True
    if found: lines[i] = None

for l in lines:
    if l: print l

