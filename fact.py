#!/usr/bin/python
import argparse, sys, math


class Range(argparse.Action):
    def __init__(self, min=None, max=None, *args, **kwargs):
        self.min = min
        self.max = max
        kwargs["metavar"] = "[%d-%d]" % (self.min, self.max)
        super(Range, self).__init__(*args, **kwargs)

    def __call__(self, parser, namespace, value, option_string=None):
        if not (self.min <= value <= self.max):
            msg = 'invalid choice: %r (choose from [%d-%d])' % \
                (value, self.min, self.max)
            raise argparse.ArgumentError(self, msg)
        setattr(namespace, self.dest, value)

parser = argparse.ArgumentParser(description='Calculate the factorial of an integer')
parser.add_argument('integer', metavar='N', type=int, action=Range, min=0, max=1000,
                    help='an integer for the factorial between [0-1000] ')
args = parser.parse_args()
print math.factorial(args.integer)

