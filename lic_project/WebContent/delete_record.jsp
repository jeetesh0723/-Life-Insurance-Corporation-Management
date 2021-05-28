<%@page import="java.sql.*"%>
<%

String id=request.getParameter("customer_id");
int no=Integer.parseInt(id);
int sumcount=0;
try {
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lic_project", "root", "12345");
Statement st = conn.createStatement();
st.executeUpdate("delete register,policy_details,payments,receipt,policy_sattlement from register inner join policy_details inner join payments inner join receipt inner join policy_sattlement where register.customer_id=policy_details.customer_id and policy_details.customer_id=payments.customer_id and payments.txn_id=receipt.txn_id and register.customer_id=policy_sattlement.customer_id and register.customer_id = '"+no+"'");
response.sendRedirect("admin_all.jsp");
}
catch(Exception e){}
%>