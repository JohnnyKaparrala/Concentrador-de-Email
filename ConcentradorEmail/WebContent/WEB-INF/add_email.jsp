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
		if(request.getParameter("email_senha").trim().equals("") || request.getParameter("email").trim().equals("") || request.getParameter("servidor").trim().equals("") || request.getParameter("porta").trim().equals("")  || request.getParameter("protocolo").trim().equals("")){
			%><b>Preencha todos os campos!</b><%
	    }else{
	    	
			Usuario usu = new Usuario(request.getParameter("nick"),
				  					request.getParameter("senha"),
				  					request.getParameter("email"));
			try{
				Usuarios.incluir(usu);
				session.setAttribute("usuario",usu);
				response.sendRedirect("adm_email.jsp");
			}catch(Exception ex){
				response.sendRedirect("cadastro.jsp?erro=Email+ja+cadastrado");
			}
		}
	%>

</body>
</html>