package cab;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class RideCalculatorTest {

    @Test
    public void testNormalRideFare() {
        RideCalculator rideCalculator = new RideCalculator();
        
        // Test 5 km, 10 minutes for a normal ride
        double fare = rideCalculator.calculateFare(RideCalculator.RideType.NORMAL, 5, 10);
        
        // Expected fare: (5 * 10) + (10 * 1) = 50 + 10 = 60
        assertEquals(60.0, fare);
    }

    @Test
    public void testPremiumRideFare() {
        RideCalculator rideCalculator = new RideCalculator();
        
        // Test 5 km, 10 minutes for a premium ride
        double fare = rideCalculator.calculateFare(RideCalculator.RideType.PREMIUM, 5, 10);
        
        // Expected fare: (5 * 15) + (10 * 2) = 75 + 20 = 95
        assertEquals(95.0, fare);
    }

    @Test
    public void testNormalRideWithMinimumFare() {
        RideCalculator rideCalculator = new RideCalculator();
        
        // Test 0.5 km, 1 minute for a normal ride (should trigger minimum fare)
        double fare = rideCalculator.calculateFare(RideCalculator.RideType.NORMAL, 0.4, 1);
        
        // Minimum fare should apply, so expected fare is 5
        assertEquals(5.0, fare);
    }

    @Test
    public void testPremiumRideWithMinimumFare() {
        RideCalculator rideCalculator = new RideCalculator();
        
        // Test 0.5 km, 1 minute for a premium ride (should trigger minimum fare)
        double fare = rideCalculator.calculateFare(RideCalculator.RideType.PREMIUM, 0.5, 1);
        
        // Minimum fare should apply, so expected fare is 20
        assertEquals(20.0, fare);
    }
}
