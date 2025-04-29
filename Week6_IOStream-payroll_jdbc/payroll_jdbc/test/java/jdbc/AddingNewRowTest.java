package jdbc;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;

import java.util.List;

import org.junit.Test;

public class AddingNewRowTest {
	@Test
	public void addNewRowTest() {
		int id = 28;
		String name = "ramesh";
		String department = "AI";
		LocalDate date = LocalDate.of(2024, 4,4);
		double salary = 45000.00;
		//if successfully added
		boolean result = AddingEmployeeToDatabase.addEmployee(id,name,salary,date,department);
		assertTrue(result);
		
		//size of row that has been added;
		List<EmployeePayroll>list =AddingNewRowInList.addData(result, id);
		assertEquals(list.size(),1);
		
		//object Comparision
		EmployeePayroll expected = new EmployeePayroll(id ,name,salary,date,department); 
		EmployeePayroll actual = list.get(0);
		
		assertEquals(expected,actual);
		
	}
}
