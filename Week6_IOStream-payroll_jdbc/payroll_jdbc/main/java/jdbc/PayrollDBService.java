package jdbc;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PayrollDBService {
    private static PayrollDBService payrollDBService;
    private PreparedStatement employeeByNameStatement;

    private PayrollDBService() {}

    public static PayrollDBService getInstance() {
        if (payrollDBService == null) {
            payrollDBService = new PayrollDBService();
        }
        return payrollDBService;
    }

     static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                JDBConnection.jdbcURL,
                JDBConnection.userName,
                JDBConnection.password
        );
    }

    // PreparedStatement cached here
    private void prepareStatementForEmployeeData() throws SQLException {
        if (employeeByNameStatement == null) {
            Connection connection = getConnection();
            String sql = "SELECT * FROM employee_payroll WHERE name = ?";
            employeeByNameStatement = connection.prepareStatement(sql);
        }
    }

    // Fetch employee by name
    public EmployeePayroll getEmployeeDataByName(String name) {
        try {
            prepareStatementForEmployeeData();
            employeeByNameStatement.setString(1, name);
            ResultSet resultSet = employeeByNameStatement.executeQuery();

            if (resultSet.next()) {
                // Reuse ResultSet to populate object
                int id = resultSet.getInt("id");
                String empName = resultSet.getString("name");
                double salary = resultSet.getDouble("salary");
                LocalDate startDate = resultSet.getDate("start_date").toLocalDate();

                return new EmployeePayroll(id, empName, salary, startDate);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }
    // performing mathematical operation
    public static List<SalaryStatsByGender> getSalaryStatsGroupedByGender() {
        String sql = "SELECT gender, COUNT(*) AS count, SUM(salary) AS sum, AVG(salary) AS avg, " +
                     "MIN(salary) AS min, MAX(salary) AS max " +
                     "FROM employee_payroll GROUP BY gender";

        List<SalaryStatsByGender> statsList = new ArrayList<>();

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {

            while (resultSet.next()) {
                String gender = resultSet.getString("gender");
                int count = resultSet.getInt("count");
                double sum = resultSet.getDouble("sum");
                double avg = resultSet.getDouble("avg");
                double min = resultSet.getDouble("min");
                double max = resultSet.getDouble("max");

                statsList.add(new SalaryStatsByGender(gender, count, sum, avg, min, max));
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving stats: " + e.getMessage());
        }

        return statsList;
    }

}

