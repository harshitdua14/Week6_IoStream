package cab;

public class InvoiceGenerator {
	private static final int COST_PER_MIN =1;
	private static final double COST_PER_KM = 10;
	private static final double MINIMUM_FARE =5;
	static double calculateFare(double distance,int time) {
		double fare = distance*COST_PER_KM + time * COST_PER_MIN;
		return Math.max(MINIMUM_FARE, fare);
	}
	
	//multiple ride method
	public double calculateMultipleFare(Ride[] rides) {
	    double totalFare = 0;
	    for (Ride ride : rides) {
	        totalFare += calculateFare(ride.distance, ride.time);
	    }
	    return totalFare;
	}
	//calculating total fare
	public InvoiceSummary calculateEnhancedFare(Ride[] rides) {
	    double totalFare = 0;
	    for (Ride ride : rides) {
	        totalFare += calculateFare(ride.distance, ride.time);
	    }
	    return new InvoiceSummary(rides.length, totalFare);
	}


}
