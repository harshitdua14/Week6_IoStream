package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeePayrollService {
	String jdbcURL = JDBConnection.jdbcURL;
	String userName = JDBConnection.userName;
	String password = JDBConnection.password;
	
	 List<EmployeePayroll> readEmployeePayrollData(){
		List<EmployeePayroll> employeeList = new ArrayList<>();
		
		String sql ="select * from employee_payroll";
		
		try(Connection connection = DriverManager.getConnection(jdbcURL, userName, password);
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(sql)){
			
			while(resultSet.next()) {
				int id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				double salary = resultSet.getDouble("salary");
				
				Date sqlDate = resultSet.getDate("start_date");
				
				LocalDate startDate = (sqlDate!=null)?sqlDate.toLocalDate():null;
				
				EmployeePayroll emp = new EmployeePayroll(id,name,salary,startDate);
				employeeList.add(emp);
			}
			
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		
		return employeeList;
	}
}
