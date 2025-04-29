package jdbc;

import org.junit.jupiter.api.Test;
import java.sql.*;
import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.*;

public class EmployeePayrollTest {

    @Test
    public void givenNewSalary_WhenUpdated_ShouldMatchWithDatabase() throws SQLException {
        String name = "Terissa";
        double updatedSalary = 3000000.00;

        // Step 1: Update salary in DB
        boolean isUpdated = UpdateSalary.updateEmployeeSalary(updatedSalary, name);
        assertTrue(isUpdated, "Failed to update salary in database");
        // Step 2: Create and sync Java object
        EmployeePayroll terisa = new EmployeePayroll(4, name, 40000, LocalDate.of(2024, 4, 10));
        terisa.setSalary(updatedSalary);

        // Step 3: Fetch salary from DB to verify
        String query = "SELECT salary FROM employee_payroll WHERE name = ?";
        double dbSalary = 0;

        try (Connection connection = DriverManager.getConnection(
                JDBConnection.jdbcURL, JDBConnection.userName, JDBConnection.password);
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();

            assertTrue(rs.next(), "No record found in DB for " + name);
            dbSalary = rs.getDouble("salary");
        }

        // Step 4: Compare
        assertEquals(updatedSalary, dbSalary, 0.01, "DB salary does not match expected");
        assertEquals(updatedSalary, terisa.getSalary(), 0.01, "Object salary does not match expected");
    }
}
