#!/usr/bin/env python3

import sys
import re
from termcolor import colored, cprint

def do_line(colors, line):
    for (pattern, color) in colors:
        if pattern.match(line) is not None:
            line = colored(line, color)
            return line
    return line

def do_stream(colors, stream, out_stream):
    for line in stream:
        if not line.endswith('\n'):
            line = line + '\n'
        line = do_line(colors, line)
        out_stream.write(line)

if len(sys.argv) <= 1:
    EXAMPLE = """[WARN ] Cooly delivered sadistic warning
[INFO ] Self-deprecating inquiry into the time necessary to infiltrate system
[INFO ] Funny, yet, insightful retort
[INFO ] Mildly agitated declaration of mission completion. 
[INFO ] Gentle exhortation to further action
[INFO ] Overly affectionate greeting 
[WARN ] Greeting
[INFO ] Transparent rationale for conversation
[ERROR] Annoyed attempt to deflect subtext
[WARN ] Overt come-one
[ERROR] Mildly embarrassed defensiveness bordering on hostility
[INFO ] Playfully witty sign-off"""
    print('usage: %s ["pattern" "color"]+' % sys.argv[0])
    print('example: %s ".*ERROR.*" red ".*WARN.*" yellow ".*INFO.*" white ".*SUCCESS.*" green' % sys.argv[0])
    print()
    colors = [(re.compile(r'.*ERROR.*'), 'red'), (re.compile(r'.*WARN.*'), 'yellow'), (re.compile(r'.*INFO.*'), 'white')]
    do_stream(colors, EXAMPLE.split('\n'), sys.stdout)
    sys.exit(0)

patterns = sys.argv[1:]
if len(patterns) % 2 != 0:
    print('error: pattern-color mismatch %d', len(patterns))
    sys.exit(1)

colors = []
for i in range(0, len(patterns), 2):
    pattern = patterns[i]
    color = patterns[i+1]
    print('%s => %s' % (pattern, color))
    colors.append((re.compile(pattern), color))

do_stream(colors, sys.stdin, sys.stdout)
