
import java.util.Hashtable;
import java.util.Random;

import com.hazelcast.client.HazelcastClient;
import com.hazelcast.client.config.ClientConfig;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.map.IMap;
import java.time.Duration;
import java.time.Instant;

import static com.hazelcast.client.properties.ClientProperty.HAZELCAST_CLOUD_DISCOVERY_TOKEN;
import static com.hazelcast.client.properties.ClientProperty.STATISTICS_ENABLED;

public class Client {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// Client Configuration
		ClientConfig clientConfig = new ClientConfig();
		clientConfig.setClusterName("dev");
		clientConfig.getNetworkConfig().addAddress("152.67.254.247:5701");
		clientConfig.getNetworkConfig().setSmartRouting(false);
		
		// Validate Successful Connection
		HazelcastInstance client = HazelcastClient.newHazelcastClient(clientConfig);
        System.out.println(clientConfig.toString());
        System.out.println("Connection Successful!");
        
        // Initialize Dictionary
        Hashtable<String, String> my_Dict = new Hashtable<String,String>();
        
		// Prepare Map for Operations
		IMap<String, String> mapCustomers = client.getMap("customers");
		Random random = new Random();
		mapCustomers.clear();
		System.out.println("Map Cleared...");
	
		
		
		// Perform Operations
		for (int i=0;i<500000;i++)
		{
			int randomKey = random.nextInt(100000);
            my_Dict.put("key-" + randomKey + i, "value-" + randomKey);
            
		}
		
		// Start Timing Code Execution
		Instant startTime = Instant.now();
		
		// Perform Bulk Operation
		mapCustomers.putAll(my_Dict);
		
		// Calculate Execution Time Delta
		Instant endTime = Instant.now();
		Duration timeElapsed = Duration.between(startTime, endTime);
		System.out.println("Time Taken: "+ timeElapsed.toMillis() + " ms");
		System.out.println("Map Size: "+ mapCustomers.size());
		
		// End Session
		
		client.shutdown();
		
	}

}
