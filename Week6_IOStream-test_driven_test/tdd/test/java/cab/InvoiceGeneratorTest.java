package cab;



import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class InvoiceGeneratorTest {
	@Test
	public void testShouldReturnMinFare() {
		double fare = InvoiceGenerator.calculateFare(0.1,1);
		assertEquals(fare,5.0);
	}
	
	@Test
	public void testShouldReturnActualFare() {
		double fare = InvoiceGenerator.calculateFare(2,1);
		assertEquals(fare,21.0);
	}
	
	//multiple ride
	@Test
	public void testShouldReturnTotalFareForMultipleRides() {
	    InvoiceGenerator generator = new InvoiceGenerator();

	    Ride[] rides = {
	        new Ride(2.0, 5),
	        new Ride(0.1, 1)
	    };

	    double totalFare = generator.calculateMultipleFare(rides);

	    assertEquals(30.0, totalFare); // 25.0 + 5.0
	}
	
	@Test
	public void testShouldReturnInvoiceSummaryForGivenUser() {
	    String userId = "user1";

	    Ride[] rides = {
	        new Ride(3.0, 10),   // ₹30 + ₹10 = ₹40
	        new Ride(0.5, 1)     // ₹5 (min fare)
	    };

	    InvoiceService invoiceService = new InvoiceService();
	    invoiceService.addRides(userId, rides);

	    InvoiceSummary expectedSummary = new InvoiceSummary(2, 46.0);
	    InvoiceSummary actualSummary = invoiceService.getInvoice(userId);

	    // Check the totalRides and totalFare
	    assertEquals(expectedSummary.totalRides, actualSummary.totalRides);
	    assertEquals(expectedSummary.totalFare, actualSummary.totalFare, 0.01);  // Delta of 0.01 for double comparison
	    assertEquals(expectedSummary.averageFare, actualSummary.averageFare, 0.01);  // Delta of 0.01 for double comparison
	}


}
