package jdbc;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

public class Main {
	
    public static void main(String[] args) {
    	//Establishing connection
       JDBConnection.connectEstablishing();
       
       //Employee List
       EmployeePayrollService service = new EmployeePayrollService();
       List<EmployeePayroll> employeeList = service.readEmployeePayrollData();
       System.out.println("Employee Payroll Data:");
       employeeList.forEach(System.out::println);
       
       //updating salary
       if(UpdateSalary.updateEmployeeSalary(30000,"Terissa")) {
    	   System.out.println("successfully updated");
       }
       else {
    	   System.out.println("wrong argument passed");
       }
       //Accessing name
       PayrollDBService services = PayrollDBService.getInstance();
       EmployeePayroll emp = services.getEmployeeDataByName("Terissa");

       if (emp != null) {
           System.out.println("Retrieved from DB:");
           System.out.println(emp);
       } else {
           System.out.println("Employee not found!");
       }
       
       // Get employees who joined between Jan 1, 2023 and Mar 31, 2024
       List<EmployeePayroll> employees = EmployeeDataInRange.getEmployeesByStartDateRange(
               LocalDate.of(2024, 1, 24),
               LocalDate.of(2024, 4, 10)
       );

       if (employees.isEmpty()) {
           System.out.println("No employees found in this date range.");
       } else {
           System.out.println("Employees who joined in date range:");
           employees.forEach(System.out::println);
       }
       

       // Salary stats by gender
       List<SalaryStatsByGender> statsList = PayrollDBService.getSalaryStatsGroupedByGender();

       System.out.println("Salary Statistics by Gender:");
       statsList.forEach(System.out::println);
       
       //Adding Employee to db
       
//       boolean result = AddingEmployeeToDatabase.addEmployee(11,"Anshika",60000,LocalDate.of(2025, 5, 4),"CSE");
//       if(result) {
//    	  List<EmployeePayroll>newData = AddingNewRowInList.addData(result,7);
//    	  System.out.println("New Employee Added successfully");
//    	  newData.forEach(System.out::println);
//       }
//       else {
//    	   System.out.println("there is some issue while adding employee data");
//       }
       
       //Transaction
       
       /*UC8 -> Ability to also add to payroll details when a
       new Employee is added to the Payroll*/
       
       /*All the payroll fields are derived fields from the salary.
         Assumption is Deduction is 20% of Salary, taxable pay is salary –
         deductions, tax is 10% of taxable pay and net pay is salary - tax
         
         ->New Employee is added only when the two inserts are
           successful then only EmployeePayroll Object is updated
         */
       
       /*UC8(Refactor) -> same question  just added on on Cascading delete(delete in parent table affect in its child) in sql server*/
       
//       boolean successful = EmployeeService.addEmployeeWithPayroll(35, "sam", 8000, LocalDate.of(2026, 8, 9), "CIVIL");
//       if(successful) {
//    	   List<EmployeePayroll>newData = AddingNewRowInList.addData(successful,31);
//     	  System.out.println("db opereation successfull");
//     	  newData.forEach(System.out::println);
//       }
//       else {
//    	   System.out.println("there is some issue while adding employee data");
//       }
       
       
       /*UC9 -> Implement the complete ER Diagram in
				the Database
				- Refactor the code to ensure all the queries are working
				- Ensure the EmployeePayroll Class incorporates all the
				Entities identified in the ER Diagram
				- Ensure When Adding new Employee Payroll, many
				tables will be impacted and transaction in the table
				need to be implemented
				- For Department, Employee Payroll class can hold array
				of Department Name*/
       
       List<String> departments = Arrays.asList("Sales and Marketing");

       EmployeePayroll empl = AddingEmployees.addFullEmployee("Suresh", 'M', 60000, LocalDate.of(2024, 4, 12), departments);

       if (empl != null) {
           System.out.println("Employee added: " + empl);
       }
       
       /*UC10 and UC 11 cross checked that normalize table properly working with uc2 uc7 
        * and adding new employee in transaction*/
       
       /*UC12  ->  Ability to remove Employee from the
			Payroll
			- Introducing is_active boolean field in employee_payroll
			with default value true.
			- When employee is removed set is_active to false and
			remove EmployeePayroll Object from the List
			- Ensure Queries are updated to retrieve only active
			employees
			- Note: When Employee is removed from Payroll, the
			Database entry for employee is not deleted because to
			maintain the records for future for Audit Purposes*/
       
        boolean updated = DeleteEmployee.removeEmployee(2);
        if(updated) {
        	System.out.println("deleted successfully");
        }
        else {
        	System.out.print("there is some issue while deleting");
        }
        
        //reteriving active employee data
        List<EmployeePayroll>activeEmp = AccessingActiveEmployee.getActiveEmployees();
        activeEmp.forEach(System.out::println);
    }
}
