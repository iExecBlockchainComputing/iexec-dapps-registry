from geopy.distance import geodesic

from shapely.geometry import Point

from scripts.classes import *
from scripts.extras import *

def calculating_distances_taxi(data,numerations = 6):
    """
    Function which finds the best <numerations> taxi drivers for the user
    ///////////////////
    numerations <-> Number of taxi drivers to offer the user
    """
    user = data['user']

    distances = []
    #Iterates through the free taxi drivers and gets their distances from the user in meters
    for taxi_driver in data["taxi"]:
        distances.append(geodesic(user.location, taxi_driver.location).meters)

    taxi_drivers_to_offer = []
    for i in range(numerations):
        taxi = data['taxi'][distances.index(min(distances))]
        #Adds the taxi driver with the least distance to the user
        taxi_drivers_to_offer.append(taxi)

        #print("went!")
        #It removes the taxi_driver from the available taxi's so that the same taxi does not keep getting
        #added to the taxi's to offer
        data['taxi'].remove(taxi)

        #it removes the shortest distance from the list
        distances.pop(distances.index(min(distances)))

    return taxi_drivers_to_offer


#Grupiranje na vozachi so korisnikot
def get_taxi_for_user(data):
    try:
        user = User(data['user']['id'],data['user']['location'])
        if save_call_instance(user) != True:
            return False

    except:
        return False

    taxis = filter_taxis()

    #makes a list of Taxi() objects which do not have a currentGroup assigned to them and are active taxi drivers if the user is not
    #the taxi driver and the user's position is withing a 2 ____ radius of the taxi driver
    free_taxi = [taxi for taxi in taxis\
                   if Point(user.location).buffer(2).contains(Point(taxi.location))]

    #print(free_taxi)
    #print(req['token'])
    final = {"user" : user, 'taxi' : free_taxi}
    #print(final)
    #print(final)
    #x = shortest_paths(final)

    offered_taxis = calculating_distances_taxi(final,1)

    
    print(offered_taxis)
    output_data = {
        "taxi_id" : offered_taxis[0].id,
        "user_id" : user.id,
        "from" : user.location,
        "to" : data['to']
    }

    #It returns the group's temporary id and the offered taxi's in a list ( idk why since it does all of this with the firebase controller )
    return output_data

