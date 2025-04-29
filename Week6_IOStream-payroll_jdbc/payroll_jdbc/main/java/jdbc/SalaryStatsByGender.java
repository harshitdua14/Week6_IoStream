package jdbc;

public class SalaryStatsByGender {
    public String gender;
    public int count;
    public double sum;
    public double avg;
    public double min;
    public double max;

    public SalaryStatsByGender(String gender, int count, double sum, double avg, double min, double max) {
        this.gender = gender;
        this.count = count;
        this.sum = sum;
        this.avg = avg;
        this.min = min;
        this.max = max;
    }

    @Override
    public String toString() {
        return "[Gender: " + gender + ", Count: " + count + ", Sum: " + sum + ", Avg: " + avg + ", Min: " + min + ", Max: " + max + "]";
    }
}
