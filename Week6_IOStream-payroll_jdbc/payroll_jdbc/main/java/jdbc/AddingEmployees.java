package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.List;

public class AddingEmployees {
	public static EmployeePayroll addFullEmployee(String name, char gender, double salary, LocalDate startDate, List<String> departments) {
	    Connection connection = null;
	    EmployeePayroll employee = null;

	    try {
	        connection = PayrollDBService.getConnection();
	        connection.setAutoCommit(false);

	        // Insert employee
	        String insertEmp = "INSERT INTO employee_payroll (name, gender, salary, start_date) VALUES (?, ?, ?, ?)";
	        int empId;
	        try (PreparedStatement empStmt = connection.prepareStatement(insertEmp,Statement.RETURN_GENERATED_KEYS)) {
	            empStmt.setString(1, name);
	            empStmt.setString(2, String.valueOf(gender));
	            empStmt.setDouble(3, salary);
	            empStmt.setDate(4, Date.valueOf(startDate));
	            empStmt.executeUpdate();

	            ResultSet keys = empStmt.getGeneratedKeys();
	            if (keys.next()) {
	                empId = keys.getInt(1);
	            } else {
	                throw new SQLException("Failed to get employee ID.");
	            }
	        }

	        // Calculate payroll fields
	        double deductions = salary * 0.20;
	        double taxablePay = salary - deductions;
	        double tax = taxablePay * 0.10;
	        double netPay = salary - tax;

	        // Insert into payroll_details
	        String insertPayroll = "INSERT INTO payroll_details (id, basic_salary, deductions, taxable_pay, tax, net_pay) VALUES (?, ?, ?, ?, ?, ?)";
	        try (PreparedStatement payStmt = connection.prepareStatement(insertPayroll)) {
	            payStmt.setInt(1, empId);
	            payStmt.setDouble(2, salary);
	            payStmt.setDouble(3, deductions);
	            payStmt.setDouble(4, taxablePay);
	            payStmt.setDouble(5, tax);
	            payStmt.setDouble(6, netPay);
	            payStmt.executeUpdate();
	        }

	        // Insert departments
	        String getDeptIdSQL = "SELECT department_id FROM department WHERE name = ?";
	        String insertEmpDept = "INSERT INTO employee_department (employee_id, department_id) VALUES (?, ?)";
	        for (String dept : departments) {
	            int deptId;

	            // Get department id
	            try (PreparedStatement getDeptIdStmt = connection.prepareStatement(getDeptIdSQL)) {
	                getDeptIdStmt.setString(1, dept);
	                ResultSet rs = getDeptIdStmt.executeQuery();
	                if (rs.next()) {
	                    deptId = rs.getInt("department_id");
	                } else {
	                    throw new SQLException("Department not found: " + dept);
	                }
	            }

	            // Insert into employee_department
	            try (PreparedStatement empDeptStmt = connection.prepareStatement(insertEmpDept)) {
	                empDeptStmt.setInt(1, empId);
	                empDeptStmt.setInt(2, deptId);
	                empDeptStmt.executeUpdate();
	            }
	        }

	        connection.commit(); // Commit everything

	        // Create and return employee object
	        employee = new EmployeePayroll(empId, name, gender, salary, startDate, departments);

	    } catch (SQLException e) {
	        e.printStackTrace();
	        if (connection != null) {
	            try {
	                connection.rollback();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	    } finally {
	        if (connection != null) {
	            try {
	                connection.setAutoCommit(true);
	                connection.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    return employee;
	}

}
