<%@page import="java.sql.*"%>
<%

String id=request.getParameter("update_id");
int no=Integer.parseInt(id);
String updatecolumn = request.getParameter("update_column");
String recordevalue = request.getParameter("record_value");
int sumcount=0;
try {
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lic_project", "root", "12345");
Statement st = conn.createStatement();
st.executeUpdate("update policy_sattlement set mature='"+recordevalue+"' where customer_id='"+no+"'");
response.sendRedirect("admin_all.jsp");
}
catch(Exception e){}
%>
