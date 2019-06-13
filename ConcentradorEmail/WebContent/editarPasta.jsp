<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.mail.*, javax.mail.search.FlagTerm, java.util.*, javax.mail.internet.MimeMultipart, classes.*, bd.dbos.*, bd.daos.*, bd.core.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	String old  = request.getParameter("pasta").trim();
	String novo = request.getParameter("nomePasta").trim();
	
	Email atual = (Email)session.getAttribute("emailAtual");
	
	Session s = Session.getDefaultInstance(new Properties( ));
	Store store = s.getStore("imaps");
	store.connect(atual.getHost(), Integer.parseInt(atual.getPorta()), atual.getEmail(), atual.getSenha());
	
	Folder folder = store.getFolder(old);
	
	if(folder.isOpen()){
		folder.close();
	}
	
	folder.renameTo(store.getFolder(novo));
	response.sendRedirect("adm_email.jsp");
}catch(Exception ex){
	response.sendRedirect("adm_email.jsp?erro="+ex.getMessage().replaceAll("\\s+","+"));
}
%>

</body>
</html>