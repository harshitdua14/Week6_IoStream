package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AccessingActiveEmployee {
	public static List<EmployeePayroll> getActiveEmployees() {
	    List<EmployeePayroll> activeEmployees = new ArrayList<>();
	    String query = "SELECT * FROM employee_payroll WHERE is_active = TRUE";

	    try (Connection connection = PayrollDBService.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {

	        while (rs.next()) {
	            int id = rs.getInt("id");
	            String name = rs.getString("name");
	            String genderStr = rs.getString("gender"); // Get gender as a String

	            // Check if gender is null and handle accordingly
	            char gender = (genderStr != null && !genderStr.isEmpty()) ? genderStr.charAt(0) : 'U';  // 'U' for unknown or any default value

	            double salary = rs.getDouble("salary");
	            LocalDate start = rs.getDate("start_date").toLocalDate();

	            // Load departments as needed (this part depends on your setup)

	            activeEmployees.add(new EmployeePayroll(id, name, gender, salary, start, null)); // Pass department as null for now
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return activeEmployees;
	}


}
