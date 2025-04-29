package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AddingNewRowInList {
	public static List<EmployeePayroll>addData(boolean result,int id){
		List<EmployeePayroll>list = new ArrayList<>();
		String sql = "SELECT * FROM employee_payroll where id = ? ";
		try(Connection connection = PayrollDBService.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql)){
			preparedStatement.setInt(1, id);
			ResultSet rs = preparedStatement.executeQuery();
			while(rs.next()) {
				int empId = rs.getInt("id");
				String name = rs.getString("name");
				double salary = rs.getDouble("salary");
				LocalDate date = rs.getDate("start_date").toLocalDate();
				String department =rs.getString("department");
				
				EmployeePayroll emp = new EmployeePayroll(empId,name,salary,date,department);
				list.add(emp);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
