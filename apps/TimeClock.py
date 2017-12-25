#!/usr/bin/python
import argparse, sys

parser = argparse.ArgumentParser(prog='OFFICE ALARM',description='Simulate Alarm')

parser.add_argument('--activate', action='store_true', default=False,
                    dest='alarm',
                    help='Set alarm switch to on')

parser.add_argument('--desactivate', action='store_false', default=False,
                    dest='alarm',
                    help='Set alarm switch to off')

results = parser.parse_args()
if results.alarm:
   print("ON")
else:
   print("OFF")
