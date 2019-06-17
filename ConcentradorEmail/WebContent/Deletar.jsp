<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" 
    import=
    "bd.daos.*,
    bd.dbos.*,
    bd.core.*"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>

	<%
	try{
		Emails.excluir(Integer.parseInt((String)session.getAttribute("atual_id")));
		MeuResultSet emails = Emails.getEmailsDono(((Usuario)session.getAttribute("usuario")).getId());
		emails.first();
		
		session.setAttribute("atual_id", emails.getInt("id"));
		response.sendRedirect("adm_email.jsp");
	
	}catch(Exception ex){
		response.sendRedirect("adm_email.jsp?erro=" + ex.getMessage().replaceAll(" ", "%20"));
	}
		
	%>
</body>
</html>