package cab;

import java.util.HashMap;
import java.util.Map;

public class RideRepository {
    private final Map<String, Ride[]> userRides = new HashMap<>();

    public void addRides(String userId, Ride[] rides) {
        userRides.put(userId, rides);
    }

    public Ride[] getRides(String userId) {
        return userRides.get(userId);
    }
}
