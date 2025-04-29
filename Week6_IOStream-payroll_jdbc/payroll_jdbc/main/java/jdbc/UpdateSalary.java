package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateSalary {
	public static boolean updateEmployeeSalary(double newSalary,String name) {
		String sql = "Update employee_payroll SET salary = ? where name =?";
		try(Connection connection = DriverManager.getConnection(JDBConnection.jdbcURL, JDBConnection.userName, JDBConnection.password);
			PreparedStatement preparedStatement = connection.prepareStatement(sql);	){
			preparedStatement.setDouble(1, newSalary);
			preparedStatement.setString(2, name);
			int rowEffected = preparedStatement.executeUpdate();
			return rowEffected>0;
		}catch(SQLException e) {
			System.out.println(e.getMessage());
			return false;
		}
	}
}
