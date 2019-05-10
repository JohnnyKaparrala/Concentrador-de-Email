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
		String nome = request.getParameter("nome");
		Float preco = Float.parseFloat(request.getParameter("preco")); 
		Livro livro = new Livro(codigo,nome,preco);
		
		Livros.alterar(livro);
	%>
	
	<p>Nome: <%= livro.getNome()  %> </p>
	<p>Preco:<%= livro.getPreco() %> </p>
	<p>Alterado com sucesso</p>

</body>
</html>