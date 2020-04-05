import json
import datetime
import string
import random

from scripts.classes import *

"""
General Controller Functions Section
"""
extra = "test_data"
def read():
    with open(f"{extra}/in/dataset.json",'r+') as f:
        return json.loads(f.read())


def write(output_dictionary):
    with open(f"{extra}/out/dataset.json",'w+') as f:
        f.write(json.dumps(output_dictionary))

    return True


def save_call_instance(user):
    current_time = datetime.datetime.now()
    minute = str(current_time.minute)
    hour = str(current_time.hour)
    day = str(current_time.day)
    month = str(current_time.month)
    year = str(current_time.year)
    location = user.location
    parameters = False
    with open("dataset.csv",'r+') as g:
        if g.readline(0) != "start_time;pochetok\n":
            parameters = True

    with open("dataset.csv","a+") as f:

        if parameters == False:
            f.write("start_time;pochetok\n")

        f.write(f"{minute}-{hour}-{day}-{month}-{year};{location}\n")
    
    return True


def filter_taxis():
    data = read()
    taxis = []

    for taxi in data['taxi'].items():
        if taxi[1]['active'] == False:
            taxis.append(Taxi(taxi[0],taxi[1]['location']))
    return taxis

"""
Good-to-have functions
"""

def new_hash(size=26, chars=string.ascii_letters + string.digits):
    """
    Function which returns a random hash
    """
    return ''.join(random.choice(chars) for _ in range(size))


"""
Good-to-have decorators
"""

def timeit(method):
    """
    Timer decorator
    """
    def timed(*args, **kw):
        ts = time.time()
        result = method(*args, **kw)
        te = time.time()

        if 'log_time' in kw:
            name = kw.get('log_name', method.__name__.upper())
            kw['log_time'][name] = int((te - ts) * 1000)
        else:
            print('%r  %2.2f ms' % (method.__name__, (te - ts) * 1000))
        return result

    return timed

