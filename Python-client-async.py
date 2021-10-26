# Import Statements
import hazelcast
import logging
import random
from datetime import datetime
from hazelcast.config import InMemoryFormat, EvictionPolicy
import time

def put_callback(future):
    print("Map put:", future.result())


def contains_callback(future):
    print("Map contains:", future.result())


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

#Timing script execution
start_time=datetime.now()


for i in range(200000):
    random_key = str(random.randint(1, 100000))
    my_map.put("key" + random_key + str(i), "value" + random_key + str(i))
    #my_map.get("key" + random_key)


print(datetime.now()-start_time)
print("Size: ", my_map.size().result())

time.sleep(3)

##for key, async_value in my_map.entry_set().result():
##    iteration = iteration + 1
##    print(key,async_value, str(iteration))


client.shutdown()
