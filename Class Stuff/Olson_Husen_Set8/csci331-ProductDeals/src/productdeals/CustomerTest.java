package productdeals;

import java.sql.*;
import junit.framework.Assert;
import org.junit.*;
import oracle.jdbc.*;

/**
 * PS: Run the provided SQL script file to recreate the database BEFORE running this test class
 */
public class CustomerTest {
  Customer cus;
  
  @Before
  public void init() throws Exception {
    cus = new Customer();
    cus.setCustomerNumber("124");
    cus.setLast("Adams");
  }
  
  /**
   * Test of login method, of class Customer.
   */
  
  @Test
  public void testLoginReturnsTrueForAValidCustomer(){
    Assert.assertFalse(cus.isLoggedIn());
    Assert.assertTrue(cus.login());
    Assert.assertTrue(cus.isLoggedIn());
  }
  
  @Test
  public void testLoginReturnsFalseForAnInvalidCustomer(){
    cus.setCustomerNumber("ooe");
    Assert.assertFalse(cus.login());
    Assert.assertFalse(cus.isLoggedIn());
  }
  
  /**
   * Test of logout method, of class Customer.
   */
  @Test    
  public void testLogout() {
    Assert.assertFalse(cus.isLoggedIn());
    cus.login();
    Assert.assertTrue(cus.isLoggedIn());
    cus.logout();
    Assert.assertFalse(cus.isLoggedIn());
  }
  
  @Test(expected=IllegalStateException.class)
  public void testLogoutFailsIfNotLoggedIn() {
    cus.logout();
  }  
  
  /**
   * Test of getCustomerInfo method, of class Customer.
   */
  @Test    
  public void testGetCustomerInfo() throws Exception{
    cus.login();
    Assert.assertTrue(cus.isLoggedIn());
    ResultSet rs = cus.getCustomerInfo();
    if(rs.next()){
      Assert.assertTrue(rs.getString("FIRST").equals("Sally"));
      Assert.assertTrue(rs.getString("STREET").equals("481 Oak"));            
      Assert.assertTrue(rs.getString("CITY").equals("Lansing"));
      Assert.assertTrue(rs.getString("STATE").equals("MI"));
      Assert.assertTrue(rs.getString("ZIP_CODE").equals("49224"));
      Assert.assertTrue(rs.getDouble("BALANCE")==818.75);
      Assert.assertTrue(rs.getDouble("CREDIT_LIMIT")==1000.00);
      Assert.assertTrue(rs.getString("SLSREP_NUMBER").equals("03"));
    }
    else{
      Assert.fail("INFO RESULT SET WAS EMPTY");
    }
  }   
  
  @Test(expected=IllegalStateException.class)
  public void testGetCustomerInfoFailsIfNotLoggedIn() throws Exception{
    Assert.assertFalse(cus.isLoggedIn());
    cus.getCustomerInfo();
    
  }     
  
  /**
   * Test of editCustomerInfo method, of class Customer.
   */
  @Test
  public void testEditCustomerInfo() throws Exception{
    Assert.assertTrue(cus.login());
    cus.setFirst("aaa");        
    cus.setStreet("aaa");
    cus.setCity("aaa");
    cus.setState("aa");
    cus.setZipCode("aaaaa");
    cus.setBalance(1);
    cus.setCreditLimit(1);
    cus.setSlsRepNumber("aa");
    cus.editCustomerInfo();
    
    ResultSet rs = cus.getCustomerInfo();
    if(rs.next()){
      Assert.assertTrue(rs.getString("CUSTOMER_NUMBER").equals("124"));
      Assert.assertTrue(rs.getString("FIRST").equals("aaa"));
      Assert.assertTrue(rs.getString("STREET").equals("aaa"));
      Assert.assertTrue(rs.getString("CITY").equals("aaa"));
      Assert.assertTrue(rs.getString("STATE").equals("aa"));
      Assert.assertTrue(rs.getString("ZIP_CODE").equals("aaaaa"));
      Assert.assertTrue(rs.getDouble("BALANCE")==818.75);
      Assert.assertTrue(rs.getDouble("CREDIT_LIMIT")==1000.00);
      Assert.assertTrue(rs.getString("SLSREP_NUMBER").equals("03"));
      cus.setFirst("Salt");        
      cus.setStreet("481 Oak");
      cus.setCity("Lansing");
      cus.setState("MI");
      cus.setZipCode("49224");
      cus.editCustomerInfo();
      cus.getCustomerInfo();
      Assert.assertTrue(rs.getString("CUSTOMER_NUMBER").equals("124"));
      Assert.assertTrue(rs.getString("FIRST").equals("aaa"));
      Assert.assertTrue(rs.getString("STREET").equals("aaa"));
      Assert.assertTrue(rs.getString("CITY").equals("aaa"));
      Assert.assertTrue(rs.getString("STATE").equals("aa"));
      Assert.assertTrue(rs.getString("ZIP_CODE").equals("aaaaa"));
      Assert.assertTrue(rs.getDouble("BALANCE")==818.75);
      Assert.assertTrue(rs.getDouble("CREDIT_LIMIT")==1000.00);
      Assert.assertTrue(rs.getString("SLSREP_NUMBER").equals("03"));  
      cus.setFirst("Sally");        
      cus.setStreet("481 Oak");
      cus.setCity("Lansing");
      cus.setState("MI");
      cus.setZipCode("49224");
      cus.setBalance(818.75);
      cus.setCreditLimit(1000.00);
      cus.setSlsRepNumber("03");
      cus.editCustomerInfo(); 
      cus.editCustomerInfo();   
    }
    else{
      Assert.fail("INFO RESULT SET WAS EMPTY");
    }
  }
  
  @Test(expected=IllegalStateException.class)
  public void testEditCustomerInfoFailsIfNotLoggedIn() throws Exception{
    Assert.assertFalse(cus.isLoggedIn());
    cus.editCustomerInfo();
  } 
  
  /**
   * Test of getAllTransactions method, of class Customer.
   */
  @Test
  public void testGetAllTransactions() throws Exception{
    Assert.assertTrue(cus.login());
    ResultSet rs = cus.getAllTransactions();
    if(rs.next()){
      Assert.assertTrue(rs.getString("TRANS_NUMBER").equals("12489"));
      if(rs.next())
        Assert.assertTrue(rs.getString("TRANS_NUMBER").equals("12500"));
      else
        Assert.fail("CUSTOMER SHOULD HAVE TWO TRANSACTIONS --- missing PART 12500");
    }
    else
      Assert.fail("CUSTOMER SHOULD HAVE TWO TRANSACTION --- missing PART 12489");
  }
  
  @Test(expected=IllegalStateException.class)
  public void testGetAllTransactionsFailsIfNotLoggedIn() throws Exception{
    Assert.assertFalse(cus.isLoggedIn());
    cus.getAllTransactions();
  }  
  
  /**
   * Test of getTransactionParts method, of class Customer.
   */
  @Test
  public void testGetTransactionParts() throws Exception{
    cus.setLast("Nelson");
    cus.setCustomerNumber("522");
    Assert.assertTrue(cus.login());
    ResultSet rs = cus.getTransactionParts("12498");
    if(rs.next()){
      
      Assert.assertTrue(rs.getString("PART_NUMBER").equals("AZ52"));
      System.out.print("part 1 works");
      
      if(rs.next())
        Assert.assertTrue(rs.getString("PART_NUMBER").equals("BA74"));
      else
        Assert.fail("CUSTOMER TRANS SHOULD HAVE TWO PARTS --- missing PART BA74");
    }
    else
      Assert.fail("CUSTOMER TRANS SHOULD HAVE TWO PARTS --- missing PART AZ52");
    rs = cus.getTransactionParts("12411");
    Assert.assertTrue(!rs.next());
  }
  
  @Test(expected=IllegalStateException.class)
  public void testGetTransactionPartsFailsIfNotLoggedIn() throws Exception{
    Assert.assertFalse(cus.isLoggedIn());
    cus.getTransactionParts("12411");
  }  
  
  /**
   * Test of getTransactionTotalValue method, of class Customer.
   */
  @Test
  public void testGetTransactionTotalValue() throws Exception{
    cus.setLast("Nelson");
    cus.setCustomerNumber("522");
    Assert.assertTrue(cus.login());
    Assert.assertTrue(cus.getTransactionTotalValue("12498")==125.7);
    Assert.assertTrue(cus.getTransactionTotalValue("12500")==149.99);
    Assert.assertTrue(cus.getTransactionTotalValue("11122")==0.0);
  }
  
  @Test(expected=IllegalStateException.class)
  public void testGetTransactionTotalValueFailsIfNotLoggedIn() throws Exception{
    Assert.assertFalse(cus.isLoggedIn());
    cus.getTransactionTotalValue("12411");
  }
}
