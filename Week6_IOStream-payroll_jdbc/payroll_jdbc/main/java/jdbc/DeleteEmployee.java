package jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteEmployee {
	public static boolean removeEmployee(int id) {
		String sql = "update employee_payroll set is_active = false where id = ?";
		try(Connection connection = PayrollDBService.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql)){
			preparedStatement.setInt(1,id);
			int rowAffect = preparedStatement.executeUpdate();
			return rowAffect>0;
		}catch(SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
}
