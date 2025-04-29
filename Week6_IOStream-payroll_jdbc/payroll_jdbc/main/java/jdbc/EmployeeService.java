package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

public class EmployeeService {
	public static boolean addEmployeeWithPayroll(int id,String name,double salary,LocalDate date,String department) {
		Connection connection = null;
		boolean isSuccessfull = false;
		
		String insertEmployeeSql ="Insert Into employee_payroll(id,name,salary,start_date,department)Values(?,?,?,?,?)";
		String insertPayrollSql = "INSERT INTO payroll_details (id, basic_salary, deductions, taxable_pay, tax, net_pay) VALUES (?, ?, ?, ?, ?, ?)";
		try{
			connection = PayrollDBService.getConnection();
			connection.setAutoCommit(false);//transaction begin
			
			try(PreparedStatement preparedStatement = connection.prepareStatement(insertEmployeeSql);){
				preparedStatement.setInt(1,id);
				preparedStatement.setString(2, name);
                preparedStatement.setDouble(3, salary);
                preparedStatement.setDate(4, Date.valueOf(date));
                preparedStatement.setString(5, department);
                
                preparedStatement.executeUpdate();
			}
			 // Step 2: Calculate payroll details
            double deductions = salary * 0.20;
            double taxablePay = salary - deductions;
            double tax = taxablePay * 0.10;
            double netPay = salary - tax;
            
            try(PreparedStatement preparedStatement = connection.prepareStatement(insertPayrollSql)){
            	 preparedStatement.setInt(1, id);
                 preparedStatement.setDouble(2, salary);
                 preparedStatement.setDouble(3, deductions);
                 preparedStatement.setDouble(4, taxablePay);
                 preparedStatement.setDouble(5, tax);
                 preparedStatement.setDouble(6, netPay);
                 preparedStatement.executeUpdate();
            }
            connection.commit(); //commit both
            isSuccessfull = true;
			
		}catch(SQLException e) {
			e.printStackTrace();
			if(connection!=null) {
				try {
					connection.rollback();
				}
				catch(SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
		finally {
			if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
		}
		return isSuccessfull;
				
	}
}
