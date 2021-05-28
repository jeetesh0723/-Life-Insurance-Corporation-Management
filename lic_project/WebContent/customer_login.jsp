<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
//String uname = request.getParameter("uname");
//String pass = request.getParameter("psw");

String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "lic_project";
String userId = "root";
String password = "12345";
try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h2 align="center"><font><strong>You Submitted LIC Report</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>
</tr>
<tr bgcolor="#A52A2A">
<td><b>CUSTOMER NAME</b></td>
<td><b>PAN</b></td>
<td><b>DOB</b></td>
<td><b>GENDER</b></td>
<td><b>EMAIL</b></td>
<td><b>ADDRESS</b></td>
<td><b> POLICY NUMBER</b></td>
<td><b> POLICY TYPE</b></td>
<td><b> PREMIUM TYPE</b></td>
<td><b> DATE </b></td>
<td><b> AMOUNT </b></td>
<td><b> TOTAL AMOUNT</b></td>
<td><b> RATE OF INTEREST</b></td>
<td><b> STATUS</b></td>
<td><b> MATURE </b></td>
<td><b> FINAL AMOUNT</b></td>
</tr>

<%
try{ 
String uname = request.getParameter("uname");
String pass = request.getParameter("psw");

connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
//String pass = "7352625265";
resultSet = statement.executeQuery("select r.customer_id,r.customer_name,r.pan_number,r.dob,r.gender,r.email,r.address,r.password,po.policy_number,po.policy_type,p.premium_type,p.date,p.amount,p.total_amount,p.rate_of_interest,re.status,pol.mature,pol.final_amount from register r,policy_details po,payments p,receipt re,policy_sattlement pol where r.customer_id=po.customer_id and po.customer_id=p.customer_id and p.txn_id=re.txn_id and r.customer_id=pol.customer_id and r.customer_name = '"+uname+"' and r.password = '"+pass+"'; ");
if(resultSet.next())
		{
			if(resultSet.getString(8).equals(pass))
			{
					%>
					<tr bgcolor="#E6E6FA">
					<td><%=resultSet.getString("customer_name") %></td>
					<td><%=resultSet.getString("pan_number") %></td>
					<td><%=resultSet.getString("dob") %></td>
					<td><%=resultSet.getString("gender") %></td>
					<td><%=resultSet.getString("email") %></td>
					<td><%=resultSet.getString("address") %></td>
					<td><%=resultSet.getString("policy_number") %></td>
					<td><%=resultSet.getString("policy_type") %></td>
					<td><%=resultSet.getString("premium_type") %></td>
					<td><%=resultSet.getString("date") %></td>
					<td><%=resultSet.getString("amount") %></td>
					<td><%=resultSet.getString("total_amount") %></td>
					<td><%=resultSet.getString("rate_of_interest") %></td>
					<td><%=resultSet.getString("status") %></td>
					<td><%=resultSet.getString("mature") %></td>
					<td><%=resultSet.getString("final_amount") %></td>
					</tr>
					<% 
			}
			else
			{
				out.println("invalid user ");
			}
		}

   } 
catch (Exception e) 
{
	e.printStackTrace();
}
%>
</table>

</body>
</html>