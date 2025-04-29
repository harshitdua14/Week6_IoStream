package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDataInRange {
	public static List<EmployeePayroll>getEmployeesByStartDateRange(LocalDate start, LocalDate end){
		List<EmployeePayroll> employeeList = new ArrayList<>();

        String sql = "SELECT * FROM employee_payroll WHERE start_date BETWEEN ? AND ?";
        try (Connection connection = DriverManager.getConnection(JDBConnection.jdbcURL,JDBConnection.userName,JDBConnection.password);
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(start));
            ps.setDate(2, Date.valueOf(end));

            ResultSet resultSet = ps.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double salary = resultSet.getDouble("salary");
                LocalDate date = resultSet.getDate("start_date").toLocalDate();

                employeeList.add(new EmployeePayroll(id, name, salary, date));
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return employeeList;
    }
	
}
