package cab;

import java.util.Objects;

public class InvoiceSummary {
    public final int totalRides;
    public final double totalFare;
    public final double averageFare;

    public InvoiceSummary(int totalRides, double totalFare) {
        this.totalRides = totalRides;
        this.totalFare = totalFare;
        this.averageFare = totalFare / totalRides;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InvoiceSummary that = (InvoiceSummary) o;
        return totalRides == that.totalRides &&
               Double.compare(that.totalFare, totalFare) == 0 &&
               Double.compare(that.averageFare, averageFare) == 0;
    }

    @Override
    public int hashCode() {
    	double roundedFare = Math.round(totalFare * 100.0) / 100.0;
        double roundedAvgFare = Math.round(averageFare * 100.0) / 100.0;
        return Objects.hash(totalRides, roundedFare, roundedAvgFare);
    }
}
