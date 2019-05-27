<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Consultar</title>
</head>
<body>
  
	<%
		
		
		try{
			Usuario usu = Usuarios.getUsuarioNick(request.getParameter("user"));
			if(usu.getSenha().equals(request.getParameter("senha"))){
				session.setAttribute("usuario",usu);
				response.sendRedirect("adm_email.jsp");				
			}
			response.sendRedirect("login.jsp?erro=usuario+sem+cadastro");
		}catch(Exception ex){
			response.sendRedirect("login.jsp?erro="+ex.getMessage().replaceAll("\\s+","+"));
		}
		
	%>

</body>
</html>