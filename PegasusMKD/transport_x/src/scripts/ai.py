import pandas as pd
import numpy as np
import keras
import sklearn
from sklearn import linear_model
from sklearn.utils import shuffle
from sklearn.preprocessing import StandardScaler,OneHotEncoder, LabelBinarizer
from sklearn.metrics import accuracy_score

from shapely.geometry import Point
import ast

from scripts.extras import read,write,filter_taxis
from scripts.taxi import calculating_distances_taxi

def filter_pandas_data():
    data = pd.read_csv("dataset.csv", sep=";")
    print(data)
    #Preobrabotka na csv vo normalna forma potrebna za nashiot training
    data = data[['start_time','pochetok']]
    data_dict = {}
    dataset = {
        #"minute" : [],
        "hour" : [],
        "day" : [],
        "month" : [],
        "year" : [],
        "location" : []
        }
    location_prefixes = []
    max_counter = 0
    for idx,row in data.iterrows():
        coordinates = []
        tmp_time = row['start_time'].split('-')
        #'minute',
        for attry,valy in zip(['hour','day','month','year'],tmp_time):
            dataset[attry].append(int(valy))
        if row['pochetok'] not in location_prefixes:
            location_prefixes.append(row['pochetok'])
        dataset['location'].append(location_prefixes.index(row['pochetok']))

    df = pd.DataFrame(dataset)
    return df,max_counter,location_prefixes

def train_model():
    data,counter,_ = filter_pandas_data()
    sc = StandardScaler()
    
    predict = "location"

    x = np.array(data.drop([predict], 1))
    y = np.array(data[predict])
    best = 0
    x = sc.fit_transform(x)

    for _ in range(10):
        train_data, test_data, train_labels, test_labels = sklearn.model_selection.train_test_split(x, y, test_size = 0.1)
        
        number_for_validate = 10000
        data_to_train_on = train_data[number_for_validate:]
        labels_to_train_on = train_labels[number_for_validate:]

        data_to_evaluate_on = train_data[:number_for_validate]
        labels_to_evaluate_on = train_labels[:number_for_validate]

        output_size = max(y) + 1

        model = keras.Sequential()

        model.add(keras.layers.Dense(output_size*5,activation="relu"))
        model.add(keras.layers.Dense(output_size*2,activation="relu"))
        model.add(keras.layers.Dense(output_size,activation="linear")) # softmax also works
    
        model.compile(optimizer="sgd", loss="sparse_categorical_crossentropy", metrics=['accuracy'])

        #Good: sgd
        fitModel = model.fit(data_to_train_on,labels_to_train_on,epochs=20,batch_size=512,validation_data=(data_to_evaluate_on,labels_to_evaluate_on))
        model = keras.models.load_model("model.h5")
        y_pred = model.predict(test_data)

        pred = list()
        test = list()

        for i in range(len(y_pred)):
            pred.append(np.argmax(y_pred[i]))

        for g in range(len(test_labels)):
            test.append(test_labels[i])

        for i,b in zip(pred,test):
            print(i,b,sep="####")

        acc = accuracy_score(pred,test)
        print(f"{_}. Accuracy is: {acc*100}")
        if acc*100 > best:
            best = acc*100
            model.save("model.h5")
            print(f"ADDED THE {_} ITERATION AS A MODEL!")

    return True


def predict(data):
    __,_,mapping = filter_pandas_data()
    model = keras.models.load_model("models/model.h5")
    data_model = {
        #"minute" : [],
        "hour" : [],
        "day" : [],
        "month" : [],
        "year" : [],
        }
    tmp_time = data['time'].split("-")
    #'minute',
    for attry,valy in zip(['hour','day','month','year'],tmp_time):
            data_model[attry].append(int(valy))

    dataframe = pd.DataFrame(data_model)
    prediction = model.predict(dataframe)
    location = ast.literal_eval(mapping[np.argmax(prediction[0])])


    #Filtering begins

    taxis = filter_taxis()
    taxi_nearby = [taxi for taxi in taxis\
                   if Point(location).buffer(6).contains(Point(taxi.location))]

    #If it finds less than 3 taxi drivers in a range of 6 __?__, then look for the closest ones no matter the region
    if len(taxi_nearby) < 3:
        nearby_data = {'user' : location, 'taxi' : taxis}
        taxi_nearby.expand(calculating_distances_taxi(nearby_data))


    output_data = {
        "location" : location,
        "taxis" : [taxi.id for taxi in taxi_nearby[:3]]
        }

    return output_data
