<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
  
	<%
		try{
			boolean tem_ssl = request.getParameter("protocolo").contains("s");
			String email = (String)request.getParameter("email");
			
			if(!(email.contains("@") && email.contains(".")))
				throw new Exception("Email invalido");
			
			Email eml = new Email(	(((Usuario)session.getAttribute("usuario")).getId()),
									request.getParameter("email"),
				  					request.getParameter("protocolo"),
				  					request.getParameter("host"),
				  					request.getParameter("porta"),
				  					request.getParameter("senha"),
				  					tem_ssl);
		
			Emails.incluir(eml);
			response.sendRedirect("adm_email.jsp");
		}catch(Exception ex){
			response.sendRedirect("adm_email.jsp?erro=" + ex.getMessage());
		}
	%>

</body>
</html>