package jdbc;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Enumeration;

public class JDBConnection {
	 static String jdbcURL = "jdbc:Mysql://localhost:3306/payroll_service?useSSL=false";
     static String userName = "root";
     static String password = "ashu";
    private static Connection con;
	 static void connectEstablishing()
	 {
	     try {
	     	Class.forName("com.mysql.cj.jdbc.Driver");
	     	System.out.println("Driver loaded");
	     }
	     catch(ClassNotFoundException e) {
	     	throw new IllegalStateException("Driver Not Found in the classPath",e);
	     }
	     listDriver();
	     try {
	     	System.out.println("Connecting to database: "+jdbcURL);
	     	con = DriverManager.getConnection(jdbcURL, userName, password);
	     	System.out.println("Connecting succefully!!! ");
	     }
	     catch(Exception e) {
	     	e.printStackTrace();
	     }
	 }
     
     private static void listDriver() {
 		Enumeration<Driver>driverList = DriverManager.getDrivers();
 		while(driverList.hasMoreElements()){
 			Driver driverClass = (Driver)driverList.nextElement();
 			System.out.println(driverClass.getClass().getName());
 		}
 	}
}
