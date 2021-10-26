# Import Statements
import hazelcast
import logging
import random
from datetime import datetime


# Initializing dictionary variable
my_dict = {}

# Enable logging to see the logs
logging.basicConfig(level=logging.DEBUG)

# Connect to Hazelcast cluster
client = hazelcast.HazelcastClient(cluster_name="dev", cluster_members = ['152.67.254.247:5701'], smart_routing=False)

# Setting up map in cluster
my_map = client.get_map("map").blocking()
my_map.put("key", "value")


if my_map.get("key") == "value":
    #print("Successfully connected!")
    #print("Now, 'map' will be filled with random entries.")
    #print("Size: ", my_map.size())
    #print("Clearing Map")
    my_map.clear()
    #print("Size: ", my_map.size())

    # Populating dictionary to bulk add
    for i in range(500000):
        random_key = str(random.randint(1, 100000))+ str(i)
        random_value = random_key+ "unique"
        my_dict[random_key] = random_value

    #Timing script execution
    start_time=datetime.now()

    # Performing bulk operation
    my_map.put_all(my_dict)
    
    # Calculating execution time
    print(datetime.now()-start_time)

    # Validating all entries were added
    print(my_map.size())

    # Ending session
    client.shutdown()

    #Exception handling
else:
    client.shutdown()
    raise Exception("Connection failed, check your configuration.")
