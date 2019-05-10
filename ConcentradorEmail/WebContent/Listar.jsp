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
	<table >
		<tr>
			<th>Codigo</th>
			<th>Nome  </th>
			<th>Preco </th>
		</tr>
			<%
				Livro[] livro;
				livro = Livros.getArrayLivros();
				for(int i = 0; i < livro.length; i++)
				{
			%>			
				<tr>
					<td><%= livro[i].getCodigo() %></td>
					<td><%= livro[i].getNome() %></td>
					<td><%= livro[i].getPreco() %></td>
				</tr>
			<%
				}	
			%>

	</table>
	<p> Listado </p>

</body>
</html>