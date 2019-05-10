<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 
    import=
    "bd.daos.*,
    bd.dbos.*"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Consultar</title>
</head>
<body>

	<%
		int codigo = Integer.parseInt(request.getParameter("codigo"));
		Livros.excluir(codigo);
	%>
	
	<p> Deleta isso </p>

</body>
</html>