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
		if(!request.getParameter("senha").equals(request.getParameter("senha_cnf"))){
			response.sendRedirect("cadastro.jsp?erro=Senhas+diferem");
	    }else{
			Usuario usu = new Usuario(request.getParameter("nick"),
				  					request.getParameter("email"),
				  					request.getParameter("senha"));
			try{				
				Usuarios.incluir(usu);
				
				Usuario get = Usuarios.getUsuarioNick(usu.getNick());
				
				session.setAttribute("usuario",get);
				session.setAttribute("pasta_atual", "inbox");	
				response.sendRedirect("adm_email.jsp");
			}catch(Exception ex){
				response.sendRedirect("cadastro.jsp?erro=Email+ja+cadastrado");
			}
		}
	}
	catch(Exception erro)
	{
		response.sendRedirect("cadastro.jsp?erro="+ erro.getMessage().replaceAll(" ", "+"));
	}
	%>

</body>
</html>