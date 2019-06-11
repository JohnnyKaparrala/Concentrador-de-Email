<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%		
		try{
			session.setAttribute("atual_id", request.getParameter("emailSelect"));
			
			response.sendRedirect("adm_email.jsp");
			
		}catch(Exception ex){
			response.sendRedirect("login.jsp?erro="+ex.getMessage().replaceAll("\\s+","+"));
			//response.sendRedirect("login.jsp?erro=deu+erro");
		}
	%>
	
	<%= session.getAttribute("atual_id") %>
</body>
</html>