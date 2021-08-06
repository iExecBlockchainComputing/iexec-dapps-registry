import json
import os
import sys
import random
import eth_abi

iexec_out = os.environ['IEXEC_OUT']

number_of_arguments = len(sys.argv)
if number_of_arguments < 2:
    print('Please input the boundaries such as: `python app/app.py [min] max`.')
    exit(1)

if (number_of_arguments == 2 and not sys.argv[1].isdigit()) \
        or (number_of_arguments == 3 and (not sys.argv[1].isdigit() or not sys.argv[2].isdigit())):
    print('Please use numeric values for the boundaries such as: `python app/app.py [min] max`.')
    exit(1)

if number_of_arguments == 2:
    min_boundary = 0
    max_boundary = int(sys.argv[1])
else:
    min_boundary = int(sys.argv[1])
    max_boundary = int(sys.argv[2])

result = random.randint(min_boundary, max_boundary)
print(result)

with open(iexec_out + '/computed.json', 'w+') as f:
    callback_data = eth_abi.encode_abi(['int'], [result]).hex()
    json.dump({"callback-data": callback_data}, f)
