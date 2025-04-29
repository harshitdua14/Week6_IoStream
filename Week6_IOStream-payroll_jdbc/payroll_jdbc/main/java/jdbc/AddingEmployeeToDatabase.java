package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class AddingEmployeeToDatabase {
		public static boolean addEmployee(int id ,String name,double salary,LocalDate date,String department) {
			String sql = "INSERT INTO employee_payroll(id,name,salary,start_date,department)Values(?,?,?,?,?)";
			try(Connection connection = PayrollDBService.getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(sql);){
				 preparedStatement.setInt(1, id);
				 preparedStatement.setString(2,name);
				 preparedStatement.setDouble(3, salary);
				 preparedStatement.setDate(4,Date.valueOf(date));//convert localDate to sql date
				 preparedStatement.setString(5, department);
				 int newRow = preparedStatement.executeUpdate();
				return newRow==1;
			}catch(SQLException e) {
				e.printStackTrace();
				return false;
			}
		}
}
