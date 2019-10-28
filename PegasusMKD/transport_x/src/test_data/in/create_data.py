import json

def create_data(func,dic={}):
    dic['function'] = func
    with open("dataset.json",'w+') as f:
        f.write(json.dumps(dic))


if __name__ == "__main__":
    one = {
        "user" : { "id" : "asd", "location" : [21.439518, 42.000514] },
        "time" : "2-21-10-2019",
        "taxi": {
            "141" : {"active" : False, "location" : [21.434792, 42.001527]},
            "231" : {"active" : True, "location" : [21.439856, 42.000618]},
            "341" : {"active" : False, "location" : [21.439963, 42.000132]},
            "441" : {"active" : False, "location" : [21.439470, 42.000451]},
            "541" : {"active" : True, "location" : [21.441212, 42.005381]},
            "641" : {"active" : False, "location" : [21.423074, 42.002344]},
            },
        "to" : [21.425885, 42.003994],
        }

    create_data('find_taxi',one)
    #create_data('predict',one)
    #create_data('train')
