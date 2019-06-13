<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.mail.*, java.util.*, classes.*,bd.*,bd.daos.*,bd.dbos.*,bd.core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Criando pasta...</title>
</head>
<body>
	<%
		try{
			String nome = request.getParameter("nomePasta").trim();
			
			Email atual = (Email)session.getAttribute("emailAtual");
			
			Session s = Session.getDefaultInstance(new Properties( ));
            Store store = s.getStore("imaps");
            store.connect(atual.getHost(), Integer.parseInt(atual.getPorta()), atual.getEmail(), atual.getSenha());
            
			Folder pasta = store.getFolder(nome);
			if(!pasta.exists()){
				if(pasta.create(Folder.HOLDS_MESSAGES)){
					pasta.setSubscribed(true);
					response.sendRedirect("adm_email.jsp");
				}
			}else{
				response.sendRedirect("adm_email.jsp?erro=Pasta+Já+Existente");
			}
			
		}catch(Exception ex){
			response.sendRedirect("adm_email.jsp?erro="+ex.getMessage().replaceAll("\\s+","+"));
		}
	%>
</body>
</html>