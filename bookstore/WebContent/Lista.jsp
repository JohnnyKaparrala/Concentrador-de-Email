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
    
    
    <div class="section container ">
    
    	<h1>Listagem</h1>
    	
	    <table class="striped highlight">
	    	<tr>
	    		<td><b>Código</b></td><td><b>Nome</b></td><td><b>Preço</b></td>
	    	</tr>
		<%
			MeuResultSet lista = Livros.getLivros();
			lista.first();
			do{
				%>
				<tr>
					<td><b><%=lista.getObject(1)%></b></td>
					<td><%=lista.getObject(2)%></td>
					<td>R$<%=lista.getObject(3)%></td>
				</tr>					
				<%
			}while(lista.next());
		%>
		</table>
	</div>

	
</body>
<script type="text/javascript" src="js/materialize.min.js"></script>
</html>