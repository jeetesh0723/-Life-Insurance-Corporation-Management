<%@page import="java.sql.*"%>
<%

String Pann =request.getParameter("pan");
String pswword = request.getParameter("psw");
String repeatpassword = request.getParameter("rpsw");
int sumcount=0;

if(pswword.equals(repeatpassword))
{
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lic_project", "root", "12345");
		Statement st = conn.createStatement();
		st.executeUpdate("update register set password='"+pswword+"' where pan_number='"+Pann+"'");
		
		   out.println("<script type=\"text/javascript\">");
		   out.println("alert('Password set successfully');");
		   out.println("location='lic.html';");
		   out.println("</script>");
		   
		}
		catch(Exception e){}
}
else
{
	   out.println("<script type=\"text/javascript\">");
	   out.println("alert('Ohh no !! password incorrect');");
	   out.println("location='forgetpass.html';");
	   out.println("</script>");
	//response.sendRedirect("forgetpass.html");
}
%>
