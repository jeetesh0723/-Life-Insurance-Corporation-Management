<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "lic_project";
String userId = "root";
String password = "12345";
try {
Class.forName(driverName);
} 
catch (ClassNotFoundException e)
{
    e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;

   String customer_n = request.getParameter("customer_n");
   String pan_n = request.getParameter("pan_num");
   String dob = request.getParameter("dobc");
   String gender = request.getParameter("gender");
   String email = request.getParameter("eml");
   String address = request.getParameter("addres");
   String psw = request.getParameter("pswc");
   
   String policy_type = request.getParameter("items_p");
   String premium_type = request.getParameter("items");
   
   int premium_type_1 = 500;
   int premium_type_2 = 3000;
   int premium_type_3 = 6000;
  
   String premium_m = "Monthly";
   String premium_q = "Quatorly";
   String premium_y = "Yearly";
     
     String connectionURL = "jdbc:mysql://localhost:3306/lic_project";      
     PreparedStatement pstatement = null;

     Class.forName("com.mysql.jdbc.Driver").newInstance();
          int updateQuery = 0;
          int getcustomer_id = 0;
          int insert_policy =  0;
          int insert_policysattlement = 0;
          String date = new java.util.Date().toString();
          int update_payments = 0;
          int update_receipt = 0;
      
          if(customer_n !=null && pan_n!=null && dob!=null && gender !=null && email!=null && address !=null && psw !=null)
          {
                if(customer_n !="" && pan_n!="" && dob!="" && gender !="" && email!="" && address !="" && psw !="")
                {
	            try {
		              connection = DriverManager.getConnection
		              (connectionURL, "root", "12345");
		              String queryString = "INSERT INTO register(customer_name,pan_number,dob,gender,email,address,password) VALUES (?, ?, ?, ?, ?, ?, ?)";
		              pstatement = connection.prepareStatement(queryString);
		              pstatement.setString(1, customer_n);		
					  pstatement.setString(2, pan_n);
					  pstatement.setString(3, dob);
					  pstatement.setString(4, gender);
					  pstatement.setString(5, email);
					  pstatement.setString(6, address);
					  pstatement.setString(7, psw);
		              updateQuery = pstatement.executeUpdate();
		              
		              
		                 if (updateQuery!= 0) 
		                    {   
		                	 connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
		                	 statement=connection.createStatement();		 
				              ResultSet rs = statement.executeQuery("select max(customer_id) from register;");
				              while (rs.next()) 
					            {
					             getcustomer_id = rs.getInt(1);
					              
					              if (getcustomer_id != 0)
					              {
					            	  if(premium_type.contains("1"))
					            	  {
					            		  connection = DriverManager.getConnection
					 		       		  (connectionURL, "root", "12345");
					            		  String queryString_1 = "INSERT INTO policy_details (customer_id,policy_number,policy_type) VALUES (?, ?, ?)";
							              pstatement = connection.prepareStatement(queryString_1);
							              pstatement.setInt(1, getcustomer_id);
										  pstatement.setInt(2, 12);
										  pstatement.setString(3, premium_m);
										  insert_policy = pstatement.executeUpdate();
										 
									  
									  if (insert_policy != 0)
					            		 {
										    connection = DriverManager.getConnection
								       		(connectionURL, "root", "12345");
								              String queryString_2 = "INSERT INTO policy_sattlement (customer_id,mature,final_amount) VALUES (?, ?, ?)";
								              pstatement = connection.prepareStatement(queryString_2);
								              pstatement.setInt(1, getcustomer_id);
											  pstatement.setString(2, "No");
											  pstatement.setInt(3, premium_type_1);
								              insert_policysattlement = pstatement.executeUpdate();
								              
								              if(insert_policysattlement != 0)
								              {		            	 
								               connection = DriverManager.getConnection
										       (connectionURL, "root", "12345");
									              String queryString_3 = "INSERT INTO payments (txn_id,customer_id,premium_type,date,amount,total_amount,rate_of_interest) VALUES (?, ?, ?, ?, ?, ?, ?)";
									              pstatement = connection.prepareStatement(queryString_3);
									              pstatement.setInt(1, getcustomer_id);
												  pstatement.setInt(2, getcustomer_id);
												  pstatement.setString(3, policy_type);
												  pstatement.setString(4, date);
												  pstatement.setInt(5, premium_type_1);
												  pstatement.setInt(6, premium_type_1);
												  pstatement.setInt(7, 10);
									              update_payments = pstatement.executeUpdate();
								              
											              if(update_payments != 0)
											              {
											            	connection = DriverManager.getConnection
													       	(connectionURL, "root", "12345");
											            	  String queryString_4 = "INSERT INTO receipt (txn_id,status,amount) VALUES (?, ?, ?)";
												              pstatement = connection.prepareStatement(queryString_4);
												              pstatement.setInt(1, getcustomer_id);
															  pstatement.setString(2, "Not Done");
															  pstatement.setInt(3, premium_type_1);
															  update_receipt = pstatement.executeUpdate();
											           
												              if(update_receipt != 0)
												              {
												            	    out.println("Data is inserted successfully");
											                        out.println("Success");
											                        String redirectURL = "payments.html";
											                        response.sendRedirect(redirectURL);
								            				  }
								              
									              
					            		 				 }
								                     }
					            		       }
				            	            }

				            	  else if(premium_type.contains("2"))
					            	  {
				            		  connection = DriverManager.getConnection
						 		       		  (connectionURL, "root", "12345");
						            		  String queryString_1 = "INSERT INTO policy_details (customer_id,policy_number,policy_type) VALUES (?, ?, ?)";
								              pstatement = connection.prepareStatement(queryString_1);
								              pstatement.setInt(1, getcustomer_id);
											  pstatement.setInt(2, 12);
											  pstatement.setString(3, premium_m);
											  insert_policy = pstatement.executeUpdate();
											 
										  
										  if (insert_policy != 0)
						            		 {
											    connection = DriverManager.getConnection
									       		(connectionURL, "root", "12345");
									              String queryString_2 = "INSERT INTO policy_sattlement (customer_id,mature,final_amount) VALUES (?, ?, ?)";
									              pstatement = connection.prepareStatement(queryString_2);
									              pstatement.setInt(1, getcustomer_id);
												  pstatement.setString(2, "No");
												  pstatement.setInt(3, premium_type_2);
									              insert_policysattlement = pstatement.executeUpdate();
									              
									              if(insert_policysattlement != 0)
									              {		            	 
									               connection = DriverManager.getConnection
											       (connectionURL, "root", "12345");
										              String queryString_3 = "INSERT INTO payments (txn_id,customer_id,premium_type,date,amount,total_amount,rate_of_interest) VALUES (?, ?, ?, ?, ?, ?, ?)";
										              pstatement = connection.prepareStatement(queryString_3);
										              pstatement.setInt(1, getcustomer_id);
													  pstatement.setInt(2, getcustomer_id);
													  pstatement.setString(3, policy_type);
													  pstatement.setString(4, date);
													  pstatement.setInt(5, premium_type_2);
													  pstatement.setInt(6, premium_type_2);
													  pstatement.setInt(7, 10);
										              update_payments = pstatement.executeUpdate();
									              
												              if(update_payments != 0)
												              {
												            	connection = DriverManager.getConnection
														       	(connectionURL, "root", "12345");
												            	  String queryString_4 = "INSERT INTO receipt (txn_id,status,amount) VALUES (?, ?, ?)";
													              pstatement = connection.prepareStatement(queryString_4);
													              pstatement.setInt(1, getcustomer_id);
																  pstatement.setString(2, "Not Done");
																  pstatement.setInt(3, premium_type_2);
																  update_receipt = pstatement.executeUpdate();
												           
													              if(update_receipt != 0)
													              {
													            	    out.println("Data is inserted successfully");
												                        out.println("Success");
												                        String redirectURL = "payments.html";
												                        response.sendRedirect(redirectURL);
									            				  }
									              
										              }
									              }
						            		 }
					            		  
					            	     }
				            	  
				            		  else if(premium_type.contains("3"))
					            	  {
				            			  connection = DriverManager.getConnection
							 		       		  (connectionURL, "root", "12345");
							            		  String queryString_1 = "INSERT INTO policy_details (customer_id,policy_number,policy_type) VALUES (?, ?, ?)";
									              pstatement = connection.prepareStatement(queryString_1);
									              pstatement.setInt(1, getcustomer_id);
												  pstatement.setInt(2, 12);
												  pstatement.setString(3, premium_m);
												  insert_policy = pstatement.executeUpdate();
												 
											  
											  if (insert_policy != 0)
							            		 {
												    connection = DriverManager.getConnection
										       		(connectionURL, "root", "12345");
										              String queryString_2 = "INSERT INTO policy_sattlement (customer_id,mature,final_amount) VALUES (?, ?, ?)";
										              pstatement = connection.prepareStatement(queryString_2);
										              pstatement.setInt(1, getcustomer_id);
													  pstatement.setString(2, "No");
													  pstatement.setInt(3, premium_type_3);
										              insert_policysattlement = pstatement.executeUpdate();
										              
										              if(insert_policysattlement != 0)
										              {		            	 
										               connection = DriverManager.getConnection
												       (connectionURL, "root", "12345");
											              String queryString_3 = "INSERT INTO payments (txn_id,customer_id,premium_type,date,amount,total_amount,rate_of_interest) VALUES (?, ?, ?, ?, ?, ?, ?)";
											              pstatement = connection.prepareStatement(queryString_3);
											              pstatement.setInt(1, getcustomer_id);
														  pstatement.setInt(2, getcustomer_id);
														  pstatement.setString(3, policy_type);
														  pstatement.setString(4, date);
														  pstatement.setInt(5, premium_type_3);
														  pstatement.setInt(6, premium_type_3);
														  pstatement.setInt(7, 10);
											              update_payments = pstatement.executeUpdate();
										              
													              if(update_payments != 0)
													              {
													            	connection = DriverManager.getConnection
															       	(connectionURL, "root", "12345");
													            	  String queryString_4 = "INSERT INTO receipt (txn_id,status,amount) VALUES (?, ?, ?)";
														              pstatement = connection.prepareStatement(queryString_4);
														              pstatement.setInt(1, getcustomer_id);
																	  pstatement.setString(2, "Not Done");
																	  pstatement.setInt(3, premium_type_3);
																	  update_receipt = pstatement.executeUpdate();
													           
														              if(update_receipt != 0)
														              {
														            	    out.println("Data is inserted successfully");
													                        out.println("Success");
													                        String redirectURL = "payments.html";
													                        response.sendRedirect(redirectURL);
										            				  }
										              
										              }
									              }
					            	           }  
				            	              }  
				            	  
				              				}      
					                     }
				            		 }
	            				}
						            catch (Exception ex) 
						            {
						              ex.printStackTrace();
						              out.println("Unable to connect to database.");
						            }
				            finally {
						                pstatement.close();
						                connection.close();
				            		}
					  }
          }
%>
 </body> 
</html>