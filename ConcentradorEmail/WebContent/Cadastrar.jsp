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
		if(request.getParameter("senha")!=request.getParameter("senha_cnf")){
			%><b>Senhas diferem!</b><%
	    }else{
			Usuario usu = new Usuario(request.getParameter("nick"),
				  					request.getParameter("nome"),
				  					request.getParameter("senha"));
			Usuarios.incluir(usu);
			%><b>foi!</b><%
	    }
	%>
	
	<p>Nome: <%= usu.getNome()  %> </p>
	<p>Email:<%= usu.getEmail() %> </p>
	<p>Senha:<%= usu.getSenha() %> </p>
	<p>Cadastrado com sucesso</p>

</body>
</html>