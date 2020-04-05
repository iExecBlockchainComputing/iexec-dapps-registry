

class User(object):
    """
    Parent class for the User,Taxi and Driver object since there are many fields which get repeated

    name <-> First name of the user
    last_name <-> Last name of the user
    user_id <-> The user's ID
    rating <-> The rating they have
    x,y <-> Their coordinates, x and y ( could be changed into a list/Array ) (lon,lat)
    """
    def __init__(self,id,location):
        #The user's ID
        self.id = str(id)
        region = None
        #Their coordinates, x and y ( could be changed into a list/Array )
        self.location = tuple(location)


#class Kompanija(models.Model):
#    """
#    Model for the taxi companies
#    """
#    name = models.CharField(max_length=75)


class Taxi(User):
    """
    Taxi object in the database

    kompanija <-> Relation between the taxi and the company
    phone <-> Their phone number
    """
    #Relation between the taxi and the company
    #kompanija = models.ForeignKey(Kompanija,related_name="kompanija",on_delete=models.CASCADE,null=True)

    #Taxi Number/ID
    def __init__(self,*args):
        super().__init__(*args)

        #Their phone number
        #self.phone=str(phone)
