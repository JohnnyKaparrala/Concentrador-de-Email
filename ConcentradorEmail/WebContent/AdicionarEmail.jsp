<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="bd.*,bd.daos.*,bd.dbos.*,bd.core.*, javax.mail.*,  java.util.*"
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
			boolean tem_ssl = request.getParameter("protocolo").contains("s");
			String email = (String)request.getParameter("email");
			String protocolo = request.getParameter("protocolo");
			String host = request.getParameter("host");
			String porta = request.getParameter("porta");
			
			try{
				Integer.parseInt(porta);
			}
			catch(Exception err)
			{
				throw new Exception("Porta deve ser um inteiro");
			}
			
			String senha = request.getParameter("senha");	          			
			
			if(!(email.contains("@") && email.contains(".")))
				response.sendRedirect("adm_email.jsp?erro=Email%20invalido");
			else
			if(protocolo.trim().equals("") ||  host.trim().equals("") || porta.trim().equals("") ||
					senha.trim().equals(""))
				response.sendRedirect("adm_email.jsp?erro=Digite%20todos%20os%20campos");
			else{
			
				Email eml = new Email(	(((Usuario)session.getAttribute("usuario")).getId()),
										email,
										protocolo,
										host,
										porta,
					  					senha,
					  					tem_ssl);
			
				Emails.incluir(eml);
				response.sendRedirect("adm_email.jsp");
			}
		}catch(Exception ex){
			System.out.println(ex.getMessage());
			response.sendRedirect("adm_email.jsp?erro=Deu+erro");
		}
	%>

</body>
</html>