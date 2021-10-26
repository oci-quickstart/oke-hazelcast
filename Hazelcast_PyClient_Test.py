# Import Statements
import hazelcast
import logging
import random
from datetime import datetime
from hazelcast.config import InMemoryFormat, EvictionPolicy



# Enable logging to see the logs
logging.basicConfig(level=logging.DEBUG)

# Connect to Hazelcast cluster
client = hazelcast.HazelcastClient(cluster_name="dev", cluster_members = ['129.159.46.112:5701'], smart_routing=False)

my_map = client.get_map("map").blocking()

my_map.put("key", "value")


if my_map.get("key") == "value":
    print("Successfully connected!")
    print("Now, 'map' will be filled with random entries.")
    print("Beginning Size: ", my_map.size())
    print("Clearing Map")
    my_map.clear()
    print("Map cleared: ", my_map.size())
    

    # Start Timing script execution
    start_time=datetime.now()

    # Perform Map Operations
    while my_map.size()<100:
        random_key = str(random.randint(1, 100000))
        my_map.put("key" + random_key, "value" + random_key)

    # Calculate Execution Time Delta
    print(datetime.now()-start_time)

    print("Final Map Size: ",my_map.size())

    # End Session
    client.shutdown()

    #Exception Handling
else:
    client.shutdown()
    raise Exception("Connection failed, check your configuration.")
