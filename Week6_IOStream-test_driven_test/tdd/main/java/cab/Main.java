package cab;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc = new Scanner(System.in);
		System.out.print("Enter distance covered by cab : " );
		double distance = sc.nextDouble();
		System.out.println("Enter the time taken by cab to cover the distance : ");
		int time = sc.nextInt();
		double fare = InvoiceGenerator.calculateFare(distance, time);
		System.out.println("Fare : "+fare);
	}

}
