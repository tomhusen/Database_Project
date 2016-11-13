import java.util.*;
import java.lang.*;
import java.io.*;
//Load JDBC API functions
import java.sql.*;
import oracle.jdbc.*;

public class JDBC_lab_Incomplete {
  
  //Variable of type database connection
  private Connection myConnection;
  //Variable of type regular statement
  private Statement stmt;
  //Variable of type prepared statement
  private PreparedStatement preparedStmt;
  //Variable of type ResultSet which will contain query output
  private ResultSet result;
  //Variables of type MetaData
  private ResultSetMetaData rsmetadata;
  
  /**
   * COMPLETE ME: done
   * REPLACE XXXXXX WITH YOUR ORACLE USERNAME AND YOUR PASSWORD
   */ 
  public JDBC_lab_Incomplete() throws SQLException, ClassNotFoundException{ 
    //Load driver and link to driver manager
    Class.forName("oracle.jdbc.OracleDriver");
    myConnection = DriverManager.getConnection("jdbc:oracle:thin:@//cscioraclesrv.ad.csbsju.edu:1521/csci.cscioraclesrv.ad.csbsju.edu","thusen", "900207243");
  }
  
  public void Method1(String dname) throws SQLException{
    stmt = myConnection.createStatement();
    String queryString = "Select e.lname as LastName, e.fname as FirstName, d.dname as Department from irahal.company_employee e,irahal.company_department d ";
    queryString += "where e.dno=d.dnumber and dname like '"+dname+"' order by dname, lname";
    System.out.println(queryString);
    result = stmt.executeQuery(queryString);
    while (result.next()){
      System.out.println(" Department: "+result.getString(3)+" FirstName: "+result.getString(2)+" LastName: "+result.getString(1));
    }
    result.close();
    stmt.close();
    System.out.println("************************************************************************");
  }
  
  
  /**
   * COMPLETE ME: done
   * REPEAT METHOD 1 again only using instance variable preparedStmt (of type PreparedStatement)
   */ 
  public void Method2(String dename) throws SQLException{
    String queryString = "Select e.lname as LastName, e.fname as FirstName, d.dname as Department from irahal.company_employee e,irahal.company_department d ";
    queryString += "where e.dno=d.dnumber and dname like ? order by dname, lname";
    
    preparedStmt = myConnection.prepareStatement(queryString);
    preparedStmt.clearParameters();
    preparedStmt.setString(1, dename);
    
    result = preparedStmt.executeQuery();
    while (result.next()){
      System.out.println(" Department: "+result.getString(3)+" FirstName: "+result.getString(2)+" LastName: "+result.getString(1));
    }
    result.close();
    preparedStmt.close();
    System.out.println("************************************************************************");
  }
  
  /**
   * COMPLETE ME: done
   * COMPLETE METHOD 3 TO INSERT THE SPECIFIED PARAMETERS AS A NEW TUPLE INTO DEPENDENT 
   * using instance variable stmt (of type Statement)
   * PS: you'll need to change the dependent name in order to rerun the insert successfully
   */  
  public void Method3(String essn, String depenName, char sex, String bDate, String relationship)  throws SQLException{
    
     stmt = myConnection.createStatement();
    
    String queryString = "INSERT into irahal.company_dependent values ('"+essn+"', '"+depenName+"', '"+sex+"',to_date('"+bDate+"','DD-MON-RR'),'"+relationship+"')";

    int returns = stmt.executeUpdate(queryString);
    
    System.out.println(queryString);
    System.out.println("Rows affected " + returns);
    
    System.out.println("Inserting Into dependent values ('"+essn+"', '"+depenName+"', '"+sex+"',to_date('"+bDate+"','DD-MON-RR'),'"+relationship+"')");
    System.out.println("************************************************************************");
  }
  
  /**
   * COMPLETE ME: ****************************************************************************************************
   * COMPLETE METHOD 4 TO ABLE TO DISPLAY RESULTS OF ANY USER INPUT SELECT QUERY 
   * USING instance variable stmt (of type Statement)
   * 
   * WHEN DONE: CHANGE METHOD SO THAT IT WORKS FOR ANY SQL QUERY (i.e., INSERT/UPDATE/DELETE AS WELL AS SELECT)
   */   
  public void Method4() throws SQLException{
    
    Scanner sc = new Scanner (System.in);
    System.out.println("Type in an sql SELECT statement and hit enter: ");
    String query = sc.nextLine();
    String q = query.toLowerCase();
    
    stmt = myConnection.createStatement();
    result = stmt.executeQuery(query);
    //???????????????????????????
    stmt.close();
    System.out.println("************************************************************************"); 
  }
  
  public void closeDatabaseVariables() throws SQLException{
    myConnection.close(); 
  }
  
  
  public static void main(String[] args){
    try{
      //Creates a new class object
      JDBC_lab_Incomplete myJDBC = new JDBC_lab_Incomplete();
      System.out.println();
      
      // Method 1 testing
      System.out.println ("\n--------METHOD 1--------\n");
      myJDBC.Method1("Administration");
      myJDBC.Method1("Potato");
      
      // Method 2 testing
      System.out.println ("\n--------METHOD 2--------\n");
      myJDBC.Method1("Administration");
      myJDBC.Method1("Potato");
      
      // Method 3 testing
      System.out.println ("\n--------METHOD 3--------\n");
      
      myJDBC.Method3("987654321", "Bug1243", 'M', "01-JAN-99","SON");
      
      // Method 4 testing
      System.out.println ("\n--------METHOD 4--------\n");
      myJDBC.Method4();
      
      myJDBC.closeDatabaseVariables();
    }
    catch(SQLException E){
      System.out.println("SQL problems:" + E);
    }
    catch(ClassNotFoundException E){
      System.out.println("Oracle driver problems:" + E);
    } 
  } 
}
