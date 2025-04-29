package cab;

public class RideCalculator {

    // Constants for normal ride
    private static final int NORMAL_RATE_PER_KM = 10;
    private static final int NORMAL_RATE_PER_MIN = 1;
    private static final int NORMAL_MIN_FARE = 5;

    // Constants for premium ride
    private static final int PREMIUM_RATE_PER_KM = 15;
    private static final int PREMIUM_RATE_PER_MIN = 2;
    private static final int PREMIUM_MIN_FARE = 20;

    public enum RideType {
        NORMAL,
        PREMIUM
    }

    public double calculateFare(RideType rideType, double distanceInKm, double timeInMin) {
        double fare = 0.0;

        switch (rideType) {
            case NORMAL:
                fare = (distanceInKm * NORMAL_RATE_PER_KM) + (timeInMin * NORMAL_RATE_PER_MIN);
                return Math.max(fare, NORMAL_MIN_FARE);  // Ensure minimum fare is applied

            case PREMIUM:
                fare = (distanceInKm * PREMIUM_RATE_PER_KM) + (timeInMin * PREMIUM_RATE_PER_MIN);
                return Math.max(fare, PREMIUM_MIN_FARE);  // Ensure minimum fare is applied

            default:
                throw new IllegalArgumentException("Invalid ride type");
        }
    }
}
