# Import Statements
import hazelcast
import logging
import random
from datetime import datetime
from hazelcast.config import InMemoryFormat, EvictionPolicy
import time

# Initializing dictionary variable
my_dict = {}

# Enable logging to see the logs
logging.basicConfig(level=logging.DEBUG)

# Connect to Hazelcast cluster
client = hazelcast.HazelcastClient(cluster_name="dev", cluster_members = ['152.67.254.247:5701'], smart_routing=False)

my_map = client.get_map("async-map")

my_map.put("key", "value")



print("Successfully connected!")
print("Now, 'map' will be filled with random entries.")
print("Size: ", my_map.size().result())
print("Clearing Map")
my_map.clear()
print("Size: ", my_map.size().result())


for i in range(500000):
    random_key = str(random.randint(1, 100000))
    my_dict["key" + random_key + str(i)] = "value" + random_key + str(i)
    #my_map.get("key" + random_key)

#Timing script execution
start_time=datetime.now()

# Async put operation
my_map.put_all(my_dict)

# Calcuate execution time delta
print(datetime.now()-start_time)
print("Size: ", my_map.size().result())

# Give map chance to fully populate from async operations
time.sleep(3)

##for key, async_value in my_map.entry_set().result():
##    iteration = iteration + 1
##    print(key,async_value, str(iteration))


client.shutdown()
