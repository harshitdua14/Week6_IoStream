package jdbc;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

public class EmployeePayroll {
    private int id;
    private String name;
    private double salary;
    private LocalDate date;
    private String department;
    private char gender;
    private List<String> departments;
    // Backward Compatibility Constructor
    public EmployeePayroll(int id, String name, double salary) {
        this(id, name, salary, null);
    }

    public EmployeePayroll(int id, String name, double salary, LocalDate date) {
        this.id = id;
        this.name = name;
        this.salary = salary;
        this.date = date;
    }
    public EmployeePayroll(int id, String name, double salary, LocalDate date,String department) {
        this.id = id;
        this.name = name;
        this.salary = salary;
        this.date = date;
        this.department = department;
    }
    
    public EmployeePayroll(int id, String name, char gender, double salary, LocalDate date, List<String> departments) {
        this.id = id;
        this.name = name;
        this.setGender(gender);
        this.salary = salary;
        this.date = date;
        this.setDepartments(departments);
    }


    // Getters and Setters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getSalary() {
        return salary;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
    
    public void setDepartment(String department) {
    	this.department = department;
    }
    
    public String getDepartment() {
    	return department;
    }
    

//    @Override
//	public int hashCode() {
//		// TODO Auto-generated method stub
//		return super.hashCode();
//	}
//
//	@Override
//	public boolean equals(Object obj) {
//		// TODO Auto-generated method stub
//		return super.equals(obj);
//	}
	
	//manually
	@Override
	public boolean equals(Object o) {
	    if (this == o) return true;
	    if (!(o instanceof EmployeePayroll)) return false;
	    EmployeePayroll ep = (EmployeePayroll) o;
	    return id == ep.id &&
	           Double.compare(ep.salary, salary) == 0 &&
	           name.equals(ep.name) &&
	           date.equals(ep.date) &&
	           department.equals(ep.department); // include department if used
	}

	@Override
	public int hashCode() {
	    return Objects.hash(id, name, salary, date, department); // include department if used
	}
	@Override
    public String toString() {
        return "EmployeePayroll [ ID : " + id + " , Name : " + name + " , Salary : " + salary + " , Date : " + date + " ]";
    }

	public List<String> getDepartments() {
		return departments;
	}

	public void setDepartments(List<String> departments) {
		this.departments = departments;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}
}
