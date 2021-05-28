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

   String card_name = request.getParameter("cardname");
   String card_number = request.getParameter("cardnumber");
   String exp_month = request.getParameter("expmonth");
   String exp_year = request.getParameter("expyear");
   String card_cvv = request.getParameter("cvv");
  
   
     String connectionURL = "jdbc:mysql://localhost:3306/lic_project";      
     PreparedStatement pstatement = null;

     Class.forName("com.mysql.jdbc.Driver").newInstance();
       String status = "success";
          int updateQuery_id = 0;
          int updatetxn_id = 0;
          int final_success = 0;
     
          if(card_name !=null && card_number!=null && exp_month !=null && exp_year !=null && card_cvv !=null)
          {
                if(card_name !="" && card_number!="" && exp_month!="" && exp_year !="" && card_cvv!="")
                {
	            try {
		              connection = DriverManager.getConnection(connectionURL, "root", "12345");
		                 connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
	                	  statement=connection.createStatement();		 
			              ResultSet rs = statement.executeQuery("select max(customer_id) from register;");
			              while (rs.next()) 
				            {
			            	  updateQuery_id = rs.getInt(1);
						        if(updateQuery_id != 0)
						          {
					 	
						        	 ResultSet rss = statement.executeQuery("select txn_id from payments where customer_id ='"+updateQuery_id+"' ");
						              while (rss.next()) 
							            {
											 updatetxn_id = rss.getInt(1);
							                 if(updatetxn_id != 0)
								              {
								            	  String final_status_done = "Update receipt set status = '"+status+"' where txn_id = '"+updatetxn_id+"' ";
								            	  pstatement = connection.prepareStatement(final_status_done);
									              final_success = pstatement.executeUpdate();
										              
											              if(final_success != 0)
													      {
											               out.println("<script type=\"text/javascript\">");
											       		   out.println("alert('Congratulations, Pyament done successfully');");
											       		   out.println("location='lic.html';");
											       		   out.println("</script>");
								     		               }
						        						    else
														      {
														      	  out.println("Not able to update !!");
														      }
								                }
							                    else
									              {
				            				           out.println("Missmatch data !!");
										          }
						                 }
						            }
				                 }	       
					           }	                      
					            catch (Exception ex) 
					            {
					              ex.printStackTrace();
					              out.println("Unable to connect to batabase.");
					            }
		            
				            finally
				            	{
					                  pstatement.close();
			      		              connection.close();
						           	}
						  }
					          
						}
%>
 </body> 
</html>