<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/materialize.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<nav class="teal lighten-1">
        <div class="nav-wrapper container ">
            <a href="index.html" class="brand-logo right">CRUD2</a>
            <ul id="nav-mobile" class="left hide-on-med-and-down">
            <li><a href="Cadastro.html">Cadastro</a></li>
            <li><a href="Update.html">Update</a></li>
            <li><a href="Selecionar.html">Selecionar</a></li>
            <li><a href="Deleta.html">Deletar</a></li>
            <li><a href="Lista.jsp">Listagem</a></li>
            </ul>
        </div>
    </nav>
	<%
		int cod = Integer.parseInt(request.getParameter("codigo"));
		Livro livro = Livros.getLivro(cod);	
	%>
	<div class="section container">
		<table>
			<tr>
				<td><b>Nome:</b></td>
				<td><i><%=livro.getNome() %></i></td>
			</tr>
			<tr>
				<td><b>Preço:</b></td>
				<td><%=livro.getPreco() %></td>
			</tr>
		</table>		
	</div>
	
</body>
<script type="text/javascript" src="js/materialize.min.js"></script>
</html>